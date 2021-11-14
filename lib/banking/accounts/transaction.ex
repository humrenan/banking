defmodule Banking.Accounts.Transaction do
  @moduledoc """
  Actions related to transaction
  """
  alias Ecto.Multi

  alias Banking.Accounts.{Deposit, Withdraw}

  alias Banking.Repo

  def call(%{"from_id" => from_id, "to_id" => to_id, "value" => value}) do
    Multi.new()
    |> Multi.run(:withdraw, fn _repo, _changes ->
      Withdraw.call(%{"id" => from_id, "value" => value})
    end)
    |> Multi.run(:deposit, fn _repo, _changes ->
      Deposit.call(%{"id" => to_id, "value" => value})
    end)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{deposit: to_account, withdraw: from_account}} ->
        {:ok, %{to_account: to_account, from_account: from_account}}
    end
  end
end
