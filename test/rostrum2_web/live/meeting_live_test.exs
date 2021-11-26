defmodule RostrumWeb.MeetingLiveTest do
  use RostrumWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rostrum.MeetingsFixtures
  import Rostrum.AccountsFixtures

  alias Rostrum.Accounts

  @create_attrs %{date: %{day: 24, hour: 4, minute: 22, month: 11, year: 2021}, title: "some title"}
  @update_attrs %{date: %{day: 25, hour: 4, minute: 22, month: 11, year: 2021}, title: "some updated title"}
  @invalid_attrs %{date: %{day: 30, hour: 4, minute: 22, month: 2, year: 2021}, title: nil}

  defp create_unit(_) do
    unit = unit_fixture()
    %{unit: unit}
  end

  defp create_user(%{unit: unit, conn: conn}) do
    conn =
      conn
      |> Map.replace!(:secret_key_base, RostrumWeb.Endpoint.config(:secret_key_base))
      |> init_test_session(%{})

    %{user: user_fixture(unit_id: unit.id), conn: conn}
  end

  defp login_user(%{conn: conn, user: user}) do
    %{conn: put_session(conn, :user_token, Accounts.generate_user_session_token(user))}
  end

  defp create_meeting(%{unit: unit}) do
    meeting = meeting_fixture(unit_id: unit.id)
    %{meeting: meeting}
  end

  describe "Index" do
    setup [:create_unit, :create_user, :login_user, :create_meeting]

    test "lists all meetings", %{conn: conn, meeting: meeting} do
      {:ok, _index_live, html} = live(conn, Routes.meeting_index_path(conn, :index))

      assert html =~ "Listing Meetings"
      assert html =~ meeting.title
    end

    test "saves new meeting", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.meeting_index_path(conn, :index))

      assert index_live |> element("a", "New Meeting") |> render_click() =~
               "New Meeting"

      assert_patch(index_live, Routes.meeting_index_path(conn, :new))

      assert index_live
             |> form("#meeting-form", meeting: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#meeting-form", meeting: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.meeting_index_path(conn, :index))

      assert html =~ "Meeting created successfully"
      assert html =~ "some title"
    end

    test "updates meeting in listing", %{conn: conn, meeting: meeting} do
      {:ok, index_live, _html} = live(conn, Routes.meeting_index_path(conn, :index))

      assert index_live |> element("#meeting-#{meeting.id} a", "Edit") |> render_click() =~
               "Edit Meeting"

      assert_patch(index_live, Routes.meeting_index_path(conn, :edit, meeting))

      assert index_live
             |> form("#meeting-form", meeting: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#meeting-form", meeting: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.meeting_index_path(conn, :index))

      assert html =~ "Meeting updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes meeting in listing", %{conn: conn, meeting: meeting} do
      {:ok, index_live, _html} = live(conn, Routes.meeting_index_path(conn, :index))

      assert index_live |> element("#meeting-#{meeting.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#meeting-#{meeting.id}")
    end
  end

  describe "Show" do
    setup [:create_unit, :create_user, :login_user, :create_meeting]

    test "displays meeting", %{conn: conn, meeting: meeting} do
      {:ok, _show_live, html} = live(conn, Routes.meeting_show_path(conn, :show, meeting))

      assert html =~ "Show Meeting"
      assert html =~ meeting.title
    end

    test "updates meeting within modal", %{conn: conn, meeting: meeting} do
      {:ok, show_live, _html} = live(conn, Routes.meeting_show_path(conn, :show, meeting))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Meeting"

      assert_patch(show_live, Routes.meeting_show_path(conn, :edit, meeting))

      assert show_live
             |> form("#meeting-form", meeting: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#meeting-form", meeting: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.meeting_show_path(conn, :show, meeting))

      assert html =~ "Meeting updated successfully"
      assert html =~ "some updated title"
    end
  end
end
