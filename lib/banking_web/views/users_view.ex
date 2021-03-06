defmodule BankingWeb.UsersView do
  use BankingWeb, :view
  alias Banking.Users.Inputs.{User}
  alias Banking.Accounts.Inputs.{Account}

  def render("create.json", %{
        user: %User{
          account: %Account{id: account_id, balance: balance},
          id: id,
          name: name,
          email: email
        }
      }) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        email: email,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end

  def render("users.json", %{users: [users]}) do
    %{users: render_many(users, __MODULE__, "acc.json")}
  end

  def render("acc.json", %{
        users: %User{
          account: %{balance: balance},
          id: id,
          name: name,
          email: email
        }
      }) do
    %{
      user: %{
        user_id: id,
        name: name,
        email: email,
        balance: balance
      }
    }
  end
end
