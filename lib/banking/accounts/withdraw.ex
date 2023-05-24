defmodule Banking.Accounts.Withdraw do
  @moduledoc """
  Actions related to withdraw
  """

  alias Banking.Accounts.Inputs.Account
  alias Banking.Repo

  def call(%{"id" => id, "value" => value}) do
    Repo.transaction(fn ->
      with true <- String.match?(value, ~r(["0-9])),
           {:ok, account} <- get_account(id),
           {:ok, updated_account} <- withdraw(account, value) do
        updated_account
      else
        {:error, reason} -> Repo.rollback(reason)
      end
    end)
  end

  defp get_account(id) do
    case Repo.get_by(Account, id: id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp withdraw(account, value) do
    balance = account.balance

    Account.changeset(account, %{balance: update_balance(balance, value)})
    |> Repo.update()
  end

  defp update_balance(balance, value), do: balance - String.to_integer(value)
  defp update_balance(balance, value) when balance <= 0, do: {:error, "Invalid withdraw value"}
end
