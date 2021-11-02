defmodule Banking.Users.Inputs.User do
  @moduledoc """
  Input parameters for users.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Banking.Accounts.Inputs.Account

  @required [:name, :email, :password]

  @derive {Jason.Encoder, except: [:__meta__]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_one :account, Account
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/)
    |> unique_constraint([:email])
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
