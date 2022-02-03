defmodule BankingWeb.UsersControllerTest do
  use BankingWeb.ConnCase

  setup do
    params = %{name: "jon", email: "jon@email.com", password: "123456"}
    {:ok, params: params}
  end

  test "sussessfully create user when valid params", ctx do
    %{
      "message" => "User created!",
      "user" => %{
        "account" => %{"balance" => 1000, "id" => _},
        "id" => _,
        "name" => "jon",
        "email" => "jon@email.com"
      }
    } =
      ctx.conn
      |> post("api/users/create", ctx.params)
      |> json_response(200)
  end
end
