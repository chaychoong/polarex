defmodule Polarex.Support.Client do
  @moduledoc """
  This module is not automatically generated.
  It is manually created to provide a Req request client for the Polar API.
  """
  alias Polarex.Support.Translator

  def request(opts) do
    case execute_request(opts) do
      {:ok, %{status: status, body: nil}} when status < 300 ->
        {:error, nil}

      {:ok, %{status: status, body: body}} when status < 300 ->
        lookup = Map.new(opts.response)
        result_type = Map.get(lookup, status)
        {:ok, Translator.translate(result_type, body)}

      # Error: 3xx+ - look up error type and translate if mapped
      {:ok, %{status: status, body: body}} ->
        lookup = Map.new(opts.response)

        case Map.get(lookup, status) do
          nil ->
            {:error, extract_message(body) || "HTTP error #{status}"}

          :null ->
            {:error, extract_message(body) || "HTTP error #{status}"}

          error_type ->
            {:error, Translator.translate(error_type, body)}
        end

      # Network/request error
      {:error, %{reason: reason}} ->
        {:error, to_string(reason)}
    end
  end

  defp execute_request(%{method: :get} = opts) do
    # Coalescing the params key so it doesn't blow up
    # https://github.com/wojtekmach/req/issues/422

    [
      url: build_endpoint(opts.url),
      params: Map.get(opts, :query, %{})
    ]
    |> Req.new()
    |> add_headers(opts.opts)
    |> Req.get()
  end

  defp execute_request(%{method: :post} = opts) do
    [
      url: build_endpoint(opts.url),
      body: encode_body(opts[:body]),
      retry: :transient
    ]
    |> Req.new()
    |> add_headers(opts.opts)
    |> Req.post()
  end

  defp execute_request(%{method: :patch} = opts) do
    [
      url: build_endpoint(opts.url),
      body: encode_body(opts[:body]),
      retry: :transient
    ]
    |> Req.new()
    |> add_headers(opts.opts)
    |> Req.patch()
  end

  defp execute_request(%{method: :put} = opts) do
    [
      url: build_endpoint(opts.url),
      body: encode_body(opts[:body]),
      retry: :transient
    ]
    |> Req.new()
    |> add_headers(opts.opts)
    |> Req.put()
  end

  defp execute_request(%{method: :delete} = opts) do
    [
      url: build_endpoint(opts.url),
      retry: :transient
    ]
    |> Req.new()
    |> add_headers(opts.opts)
    |> Req.delete()
  end

  # Helper function to build the URL
  defp build_endpoint(path) do
    host = Application.fetch_env!(:polarex, :server)

    host
    |> URI.parse()
    |> Map.put(:path, path)
    |> to_string()
  end

  # Ensure the body is encoded as JSON
  defp encode_body(nil), do: nil

  defp encode_body(%{__struct__: _} = body) do
    body
    |> Map.from_struct()
    |> encode_body()
  end

  defp encode_body(body) when is_map(body) do
    body
    |> Map.reject(fn {_, v} -> is_nil(v) end)
    |> JSON.encode!()
  end

  defp add_headers(%Req.Request{} = req, opts) do
    access_token = Application.fetch_env!(:polarex, :access_token)

    headers =
      [
        {"Authorization", "Bearer #{access_token}"},
        {"Content-Type", "application/json"}
      ]

    headers_overrides = opts[:headers] || []

    req
    |> Req.merge(headers: headers)
    |> Req.merge(headers: headers_overrides)
  end

  defp extract_message(nil), do: nil
  defp extract_message(%{"message" => message}), do: message
  defp extract_message(%{"detail" => detail}) when is_binary(detail), do: detail
  defp extract_message(_), do: nil
end
