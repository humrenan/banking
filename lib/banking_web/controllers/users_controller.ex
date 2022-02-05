defmodule BankingWeb.UsersController do
  use BankingWeb, :controller

  alias Banking
  alias Banking.Users.Inputs.User

  action_fallback BankingWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Banking.create_user(params) do
      conn
      |> put_status(200)
      |> render("create.json", user: user)
    end
  end

  def list(conn, %{}) do
    users = Banking.list()

    conn
    |> put_status(:ok)
    |> render("users.json", %{users: [users]})
  end
end
