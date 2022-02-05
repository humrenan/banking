defmodule BankingWeb.UsersControllerTest do
  use BankingWeb.ConnCase

  test "sussessfully create user when valid params", %{conn: conn} do
    params = %{name: "jon", email: "jon@email.com", password: "123456"}

    %{
      "message" => "User created!",
      "user" => %{
        "account" => %{"balance" => 1000, "id" => _},
        "id" => _,
        "name" => "jon",
        "email" => "jon@email.com"
      }
    } =
      conn
      |> post("api/users/create", params)
      |> json_response(200)
  end

  test "succeeds on listing users", %{conn: conn} do
    users =
      Enum.map(Integer.digits(123_456_789), fn num ->
        Banking.create_user(%{
          name: "Maria_#{num}",
          email: "maria_#{num}@email.com",
          password: "123456"
        })
      end)

    %{"users" => resp} =
      conn
      |> get("api/users/list")
      |> json_response(200)

    assert length(users) == length(resp)
  end
end
