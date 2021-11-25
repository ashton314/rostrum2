defmodule RostrumWeb.SettingsLive.Show do
  use RostrumWeb, :live_view

  alias Rostrum.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:settings, Accounts.get_settings!(id))}
  end

  defp page_title(:show), do: "Show Settings"
  defp page_title(:edit), do: "Edit Settings"
end
