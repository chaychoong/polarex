defmodule Polarex.CheckoutProductsCreate do
  @moduledoc """
  Provides struct and type for a CheckoutProductsCreate
  """

  @type t :: %__MODULE__{
          allow_discount_codes: boolean | nil,
          allow_trial: boolean | nil,
          amount: integer | nil,
          custom_field_data: map | nil,
          customer_billing_address: Polarex.AddressInput.t() | nil,
          customer_billing_name: String.t() | nil,
          customer_email: String.t() | nil,
          customer_id: String.t() | nil,
          customer_ip_address: String.t() | nil,
          customer_metadata: map | nil,
          customer_name: String.t() | nil,
          customer_tax_id: String.t() | nil,
          discount_id: String.t() | nil,
          embed_origin: String.t() | nil,
          external_customer_id: String.t() | nil,
          is_business_customer: boolean | nil,
          metadata: map | nil,
          prices: map | nil,
          products: [String.t()],
          require_billing_address: boolean | nil,
          return_url: String.t() | nil,
          seats: integer | nil,
          subscription_id: String.t() | nil,
          success_url: String.t() | nil,
          trial_interval: String.t() | nil,
          trial_interval_count: integer | nil
        }

  defstruct [
    :allow_discount_codes,
    :allow_trial,
    :amount,
    :custom_field_data,
    :customer_billing_address,
    :customer_billing_name,
    :customer_email,
    :customer_id,
    :customer_ip_address,
    :customer_metadata,
    :customer_name,
    :customer_tax_id,
    :discount_id,
    :embed_origin,
    :external_customer_id,
    :is_business_customer,
    :metadata,
    :prices,
    :products,
    :require_billing_address,
    :return_url,
    :seats,
    :subscription_id,
    :success_url,
    :trial_interval,
    :trial_interval_count
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allow_discount_codes: :boolean,
      allow_trial: :boolean,
      amount: {:union, [:integer, :null]},
      custom_field_data: :map,
      customer_billing_address: {:union, [{Polarex.AddressInput, :t}, :null]},
      customer_billing_name: {:union, [:string, :null]},
      customer_email: {:union, [{:string, "email"}, :null]},
      customer_id: {:union, [{:string, "uuid4"}, :null]},
      customer_ip_address: {:union, [{:string, "ipvanyaddress"}, :null]},
      customer_metadata: :map,
      customer_name: {:union, [:string, :null]},
      customer_tax_id: {:union, [:string, :null]},
      discount_id: {:union, [{:string, "uuid4"}, :null]},
      embed_origin: {:union, [:string, :null]},
      external_customer_id: {:union, [:string, :null]},
      is_business_customer: :boolean,
      metadata: :map,
      prices: {:union, [:map, :null]},
      products: [string: "uuid4"],
      require_billing_address: :boolean,
      return_url: {:union, [{:string, "uri"}, :null]},
      seats: {:union, [:integer, :null]},
      subscription_id: {:union, [{:string, "uuid4"}, :null]},
      success_url: {:union, [{:string, "uri"}, :null]},
      trial_interval: {:union, [{:enum, ["day", "week", "month", "year"]}, :null]},
      trial_interval_count: {:union, [:integer, :null]}
    ]
  end
end
