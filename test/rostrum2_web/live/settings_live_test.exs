defmodule RostrumWeb.SettingsLiveTest do
  use RostrumWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rostrum.AccountsFixtures

  @create_attrs %{active: true, contact_email: "some contact_email", public: true}
  @update_attrs %{active: false, contact_email: "some updated contact_email", public: false}
  @invalid_attrs %{active: false, contact_email: nil, public: false}

  defp create_settings(_) do
    settings = settings_fixture()
    %{settings: settings}
  end

  describe "Index" do
    setup [:create_settings]

    test "lists all settings", %{conn: conn, settings: settings} do
      {:ok, _index_live, html} = live(conn, Routes.settings_index_path(conn, :index))

      assert html =~ "Listing Settings"
      assert html =~ settings.contact_email
    end

    test "saves new settings", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.settings_index_path(conn, :index))

      assert index_live |> element("a", "New Settings") |> render_click() =~
               "New Settings"

      assert_patch(index_live, Routes.settings_index_path(conn, :new))

      assert index_live
             |> form("#settings-form", settings: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#settings-form", settings: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.settings_index_path(conn, :index))

      assert html =~ "Settings created successfully"
      assert html =~ "some contact_email"
    end

    test "updates settings in listing", %{conn: conn, settings: settings} do
      {:ok, index_live, _html} = live(conn, Routes.settings_index_path(conn, :index))

      assert index_live |> element("#settings-#{settings.id} a", "Edit") |> render_click() =~
               "Edit Settings"

      assert_patch(index_live, Routes.settings_index_path(conn, :edit, settings))

      assert index_live
             |> form("#settings-form", settings: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#settings-form", settings: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.settings_index_path(conn, :index))

      assert html =~ "Settings updated successfully"
      assert html =~ "some updated contact_email"
    end

    test "deletes settings in listing", %{conn: conn, settings: settings} do
      {:ok, index_live, _html} = live(conn, Routes.settings_index_path(conn, :index))

      assert index_live |> element("#settings-#{settings.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#settings-#{settings.id}")
    end
  end

  describe "Show" do
    setup [:create_settings]

    test "displays settings", %{conn: conn, settings: settings} do
      {:ok, _show_live, html} = live(conn, Routes.settings_show_path(conn, :show, settings))

      assert html =~ "Show Settings"
      assert html =~ settings.contact_email
    end

    test "updates settings within modal", %{conn: conn, settings: settings} do
      {:ok, show_live, _html} = live(conn, Routes.settings_show_path(conn, :show, settings))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Settings"

      assert_patch(show_live, Routes.settings_show_path(conn, :edit, settings))

      assert show_live
             |> form("#settings-form", settings: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#settings-form", settings: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.settings_show_path(conn, :show, settings))

      assert html =~ "Settings updated successfully"
      assert html =~ "some updated contact_email"
    end
  end
end
