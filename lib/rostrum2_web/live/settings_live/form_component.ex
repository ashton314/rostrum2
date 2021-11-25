defmodule RostrumWeb.SettingsLive.FormComponent do
  use RostrumWeb, :live_component

  alias Rostrum.Accounts

  @impl true
  def update(%{settings: settings} = assigns, socket) do
    changeset = Accounts.change_settings(settings)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"settings" => settings_params}, socket) do
    changeset =
      socket.assigns.settings
      |> Accounts.change_settings(settings_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"settings" => settings_params}, socket) do
    save_settings(socket, socket.assigns.action, settings_params)
  end

  defp save_settings(socket, :edit, settings_params) do
    case Accounts.update_settings(socket.assigns.settings, settings_params) do
      {:ok, _settings} ->
        {:noreply,
         socket
         |> put_flash(:info, "Settings updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_settings(socket, :new, settings_params) do
    case Accounts.create_settings(settings_params) do
      {:ok, _settings} ->
        {:noreply,
         socket
         |> put_flash(:info, "Settings created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
