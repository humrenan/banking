defmodule Banking.AccountsTest do
  use Banking.DataCase, async: true

  alias Banking.Accounts.Inputs.Account
  alias Banking.Users.Inputs.User

  describe "Banking.deposit/1" do
    test "succeeds on deposit operation" do
      assert {:ok, %User{account: account} = user} =
               Banking.create_user(%{name: "Maria", email: "maria@email.com", password: "123456"})

      params = %{"id" => account.id, "value" => "5"}
      account_id = account.id
      user_id = user.id

      assert {:ok, %Account{balance: 1005, id: ^account_id, user_id: ^user_id}} =
               Banking.deposit(params)
    end
  end

  describe "Banking.withdraw/1" do
    test "succeeds on withdraw operation" do
      assert {:ok, %User{account: account} = user} =
               Banking.create_user(%{name: "Maria", email: "maria@email.com", password: "123456"})

      params = %{"id" => account.id, "value" => "5"}
      account_id = account.id
      user_id = user.id

      assert {:ok, %Account{balance: 995, id: ^account_id, user_id: ^user_id}} =
               Banking.withdraw(params)
    end
  end

  describe "Banking.transaction/1" do
    test "succeeds on transaction operation" do
      assert {:ok, %User{account: account_1} = user_1} =
               Banking.create_user(%{name: "Maria", email: "maria@email.com", password: "123456"})

      assert {:ok, %User{account: account_2} = user_2} =
               Banking.create_user(%{name: "Jon", email: "jon@email.com", password: "123456"})

      account_1_id = account_1.id
      account_2_id = account_2.id
      user_1_id = user_1.id
      user_2_id = user_2.id

      params = %{"from_id" => account_1_id, "to_id" => account_2_id, "value" => "5"}

      assert {:ok,
              %{
                from_account: %Account{balance: 995, user_id: ^user_1_id},
                to_account: %Account{balance: 1005, user_id: ^user_2_id}
              }} = Banking.transaction(params)
    end
  end
end
