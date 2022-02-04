# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Banking.Repo.insert!(%Banking.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Enum.map(Integer.digits(123_456_789), fn num ->
  Banking.create_user(%{
    name: "Maria_#{num}",
    email: "maria_#{num}@email.com",
    password: "123456"
  })
end)
