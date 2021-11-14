defmodule Banking.Users.List do
  alias Banking.Repo

  alias Banking.Accounts.Inputs.Account
  alias Banking.Users.Inputs.User

  def call do
    Repo.all(User) |> Repo.preload([:account])
  end
end
