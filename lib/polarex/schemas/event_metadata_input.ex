defmodule Polarex.EventMetadataInput do
  @moduledoc """
  Provides struct and type for a EventMetadataInput
  """

  @type t :: %__MODULE__{
          _cost: Polarex.CostMetadataInput.t() | nil,
          _llm: Polarex.LLMMetadata.t() | nil
        }

  defstruct [:_cost, :_llm]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [_cost: {Polarex.CostMetadataInput, :t}, _llm: {Polarex.LLMMetadata, :t}]
  end
end
