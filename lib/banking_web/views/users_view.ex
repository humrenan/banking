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

  def render("users.json", %{users: users}) do
    %{users: render_many(users, __MODULE__, "acc.json" )}
  end

  def render("acc.json", %{
    users: %User{
          account: %Account{
            id: acc_id,
            balance: balance
          },
          id: id,
          name: name
        }
      }) do
    %{
      user: %{
        user_id: id,
        name: name,
        account: %{
          balance: balance,
          account_id: acc_id
        }
      }
    }
  end


end
