defmodule Banking.UsersController do
  use BankingWeb, :controller

  alias Banking
  alias Banking.Users.Inputs.User

  action_fallback BankingWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Banking.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
