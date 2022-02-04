defmodule Banking.Users.List do
  @moduledoc """
  List users
  """
  alias Banking.Repo
  alias Banking.Users.Inputs.User

  def call do
    User
    |> Repo.all()
    |> Repo.preload([:account])
  end
end
