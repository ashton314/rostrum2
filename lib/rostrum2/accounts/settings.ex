defmodule Rostrum.Accounts.Settings do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rostrum.Accounts.Unit

  schema "settings" do
    field :active, :boolean, default: false
    field :contact_email, :string
    field :public, :boolean, default: false
    field :admin_id, :id

    belongs_to :unit, Unit

    timestamps()
  end

  @doc false
  def changeset(settings, attrs) do
    settings
    |> cast(attrs, [:active, :public, :contact_email])
    |> validate_required([:active, :public, :contact_email])
  end
end
