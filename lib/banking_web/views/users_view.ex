defmodule BankingWeb.UsersView do
  use BankingWeb, :view
  alias Banking.Users.Inputs.{User}
  alias Banking.Accounts.Inputs.{Account}

  def render("create.json", %{
        user: %User{
          account: %Account{id: account_id, balance: balance},
          id: id,
          name: name
        }
      }) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end
end
