defmodule RostrumWeb.SettingsLive.Index do
  use RostrumWeb, :live_view

  alias Rostrum.Accounts
  alias Rostrum.Accounts.Settings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :settings_collection, list_settings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Settings")
    |> assign(:settings, Accounts.get_settings!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Settings")
    |> assign(:settings, %Settings{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Settings")
    |> assign(:settings, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    settings = Accounts.get_settings!(id)
    {:ok, _} = Accounts.delete_settings(settings)

    {:noreply, assign(socket, :settings_collection, list_settings())}
  end

  defp list_settings do
    Accounts.list_settings()
  end
end
