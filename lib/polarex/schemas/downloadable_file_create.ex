defmodule Polarex.DownloadableFileCreate do
  @moduledoc """
  Provides struct and type for a DownloadableFileCreate
  """

  @type t :: %__MODULE__{
          checksum_sha256_base64: String.t() | nil,
          mime_type: String.t(),
          name: String.t(),
          organization_id: String.t() | nil,
          service: String.t(),
          size: integer,
          upload: Polarex.S3FileCreateMultipart.t(),
          version: String.t() | nil
        }

  defstruct [
    :checksum_sha256_base64,
    :mime_type,
    :name,
    :organization_id,
    :service,
    :size,
    :upload,
    :version
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      checksum_sha256_base64: {:union, [:string, :null]},
      mime_type: :string,
      name: :string,
      organization_id: {:union, [{:string, "uuid4"}, :null]},
      service: {:const, "downloadable"},
      size: :integer,
      upload: {Polarex.S3FileCreateMultipart, :t},
      version: {:union, [:string, :null]}
    ]
  end
end
