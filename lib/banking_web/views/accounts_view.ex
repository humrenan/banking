defmodule BankingWeb.AccountsView do
  use BankingWeb, :view
  alias Banking.Accounts.Inputs.Account
  alias Banking.Users.Inputs.{User}

  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Balance changed successfuly!",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %{
        transaction: %{from_account: from_account, to_account: to_account}
      }) do
    %{
      message: "Successful transaction",
      transaction: %{
        from_account: %{
          id: from_account.id,
          balance: from_account.balance
        },
        to_account: %{
          id: to_account.id,
          balance: to_account.balance
        }
      }
    }
  end
end
