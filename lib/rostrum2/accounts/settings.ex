defmodule Rostrum.Accounts.Settings do
  use Ecto.Schema
  import Ecto.Changeset

  schema "settings" do
    field :active, :boolean, default: false
    field :contact_email, :string
    field :public, :boolean, default: false
    field :unit_id, :id
    field :admin_id, :id

    timestamps()
  end

  @doc false
  def changeset(settings, attrs) do
    settings
    |> cast(attrs, [:active, :public, :contact_email])
    |> validate_required([:active, :public, :contact_email])
  end
end
