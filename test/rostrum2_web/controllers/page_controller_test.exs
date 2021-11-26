defmodule RostrumWeb.PageControllerTest do
  use RostrumWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Rostrum"
  end
end
