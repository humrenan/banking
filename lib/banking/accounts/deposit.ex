defmodule Banking.Accounts.Deposit do
  @moduledoc """
  Actions related to deposit
  """
  alias Ecto.Multi

  alias Banking.Repo

  alias Banking.Accounts.Inputs.Account

  def call(%{"id" => id, "value" => value}) do
    with true <- String.match?(value, ~r(["0-9])) do
      Multi.new()
      |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
      |> Multi.run(:deposit, fn repo, changes ->
        account = Map.get(changes, :account)

        update_balance(repo, account, value, :deposit)
      end)
      |> run_transaction()
    else
      _ -> {:error, "Invalid deposit value"}
    end
  end

  defp get_account(repo, id) do
    case repo.get_by(Account, id: id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, %Account{balance: _balance} = account, value, operation) do
    account
    |> operation(value, operation)
    |> update_account(repo, account)
  end

  defp operation(%Account{balance: balance}, value, operation) do
    with true <- String.match?(value, ~r(["0-9])) do
      value
      |> String.to_integer()
      |> handle_operation(balance, operation)
    else
      _ -> {:error, "Ivalid deposit value"}
    end
  end

  defp handle_operation(value, balance, :deposit), do: balance + value

  defp update_account(value, repo, account) do
    params = %{balance: value}

    account
    |> Account.changeset(params)
    |> repo.update()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: account}} -> {:ok, account}
    end
  end
end
