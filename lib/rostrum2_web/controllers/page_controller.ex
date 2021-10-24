defmodule RostrumWeb.PageController do
  use RostrumWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
