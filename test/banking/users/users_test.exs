defmodule Banking.UsersTest do
  use BankingWeb.ConnCase, async: true
  alias Banking.Users.Inputs.User
  alias Banking.Users.List

  setup do
    user = %{
      name: "Maria",
      email: "maria@email.com",
      password: "123456"
    }

    {:ok, user: user}
  end

  test "succeeds when create user", ctx do
    assert {:ok, %User{}} = Banking.create_user(ctx.user)
  end

  test "succeds on listing users", ctx do
    {:ok, user} = Banking.create_user(ctx.user)
    name = user.name
    assert [%User{name: ^name}] = List.call()
  end
end
