defmodule BankingWeb.AccountsController do
  @moduledoc """
    Actions related to the accounts resource.
  """
  use BankingWeb, :controller
  alias Banking.{Accounts.Inputs.Account, Repo}

  action_fallback BankingWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Banking.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Banking.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %{} = transaction} <- Banking.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end

  def list(conn, %{}) do
    users = Banking.list()

    conn
    |> put_status(:ok)
    |> render("users.json", %{users: users})
  end
end
