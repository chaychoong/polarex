defmodule Polarex.S3FileUploadCompletedPart do
  @moduledoc """
  Provides struct and type for a S3FileUploadCompletedPart
  """

  @type t :: %__MODULE__{
          checksum_etag: String.t(),
          checksum_sha256_base64: String.t() | nil,
          number: integer
        }

  defstruct [:checksum_etag, :checksum_sha256_base64, :number]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [checksum_etag: :string, checksum_sha256_base64: {:union, [:string, :null]}, number: :integer]
  end
end
