defmodule Banking do

  alias Banking.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
