defmodule RostrumWeb.EventLiveTest do
  use RostrumWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rostrum.MeetingsFixtures
  import Rostrum.AccountsFixtures

  @create_attrs %{hymn: 42, note: "some note", order: 42, participants: "some participants", title: "some title", type: :hymn}
  @update_attrs %{hymn: 43, note: "some updated note", order: 43, participants: "some updated participants", title: "some updated title", type: :musical_number}
  @invalid_attrs %{hymn: nil, note: nil, order: nil, participants: nil, title: nil, type: nil}

  defp create_user(%{conn: conn}) do
    conn =
      conn
      |> Map.replace!(:secret_key_base, RostrumWeb.Endpoint.config(:secret_key_base))
      |> init_test_session(%{})

    %{user: user_fixture(), conn: conn}
  end

  defp create_event(args) do
    IO.inspect(args, label: "args")

    event = event_fixture()
    %{event: event}
  end

  describe "Index" do
    # Skipping because we probably won't need these tests, at least not in these forms
    @describetag :skip
    setup [:create_user, :create_event]

    test "lists all events", %{conn: conn, event: event} do
      {:ok, _index_live, html} = live(conn, Routes.event_index_path(conn, :index))

      assert html =~ "Listing Events"
      assert html =~ event.note
    end

    test "saves new event", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.event_index_path(conn, :index))

      assert index_live |> element("a", "New Event") |> render_click() =~
               "New Event"

      assert_patch(index_live, Routes.event_index_path(conn, :new))

      assert index_live
             |> form("#event-form", event: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#event-form", event: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_index_path(conn, :index))

      assert html =~ "Event created successfully"
      assert html =~ "some note"
    end

    test "updates event in listing", %{conn: conn, event: event} do
      {:ok, index_live, _html} = live(conn, Routes.event_index_path(conn, :index))

      assert index_live |> element("#event-#{event.id} a", "Edit") |> render_click() =~
               "Edit Event"

      assert_patch(index_live, Routes.event_index_path(conn, :edit, event))

      assert index_live
             |> form("#event-form", event: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#event-form", event: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_index_path(conn, :index))

      assert html =~ "Event updated successfully"
      assert html =~ "some updated note"
    end

    test "deletes event in listing", %{conn: conn, event: event} do
      {:ok, index_live, _html} = live(conn, Routes.event_index_path(conn, :index))

      assert index_live |> element("#event-#{event.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#event-#{event.id}")
    end
  end

  describe "Show" do
    # Skipping because we probably won't need these tests, at least not in these forms
    @describetag :skip
    setup [:create_event]

    test "displays event", %{conn: conn, event: event} do
      {:ok, _show_live, html} = live(conn, Routes.event_show_path(conn, :show, event))

      assert html =~ "Show Event"
      assert html =~ event.note
    end

    test "updates event within modal", %{conn: conn, event: event} do
      {:ok, show_live, _html} = live(conn, Routes.event_show_path(conn, :show, event))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Event"

      assert_patch(show_live, Routes.event_show_path(conn, :edit, event))

      assert show_live
             |> form("#event-form", event: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#event-form", event: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_show_path(conn, :show, event))

      assert html =~ "Event updated successfully"
      assert html =~ "some updated note"
    end
  end
end
