defmodule Banking.Users.Create do
  alias Banking.Repo
  alias Banking.Users.Inputs.User
  alias Banking.Accounts.Inputs.Account
  alias Ecto.Multi

  def call(params) do
    Multi.new()
    |> Multi.run(:create_user, fn repo, _changes -> insert_user(repo, params) end)
    |> Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(repo, user) end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction()
  end

  defp insert_user(repo, user) do
    user
    |> User.changeset()
    |> repo.insert()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: 1000}

    Account.changeset(params)
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
