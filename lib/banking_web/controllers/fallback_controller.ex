defmodule BankingWeb.FallbackController do
  use BankingWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BankingWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
