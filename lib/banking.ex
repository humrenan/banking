defmodule Banking do
  alias Banking.Users.Create, as: UserCreate
  alias Banking.Users.List
  alias Banking.Accounts.{Deposit, Transaction, Withdraw}

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call

  defdelegate list, to: List, as: :call
end
