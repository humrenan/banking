defmodule Banking.Accounts.Inputs.Account do
  @moduledoc """
  Input parameters for account
  """
  
  use Ecto.Schema
  import Ecto.Changeset
  alias Banking.Users.Inputs.User

  @required [:user_id, :balance]

  @derive {Jason.Encoder, except: [:__meta__]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "accounts" do
    field :balance, :integer

    belongs_to :user, User
    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end
