defmodule Banking.Users.List do
  alias Banking.Repo

  alias Banking.Accounts.Inputs.Account
  alias Banking.Users.Inputs.User

  def call do
    User
    |> Repo.all()
    |> Repo.preload([:account])
  end
end
