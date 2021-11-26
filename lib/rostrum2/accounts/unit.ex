defmodule Rostrum.Accounts.Unit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rostrum.Accounts.User
  alias Rostrum.Meetings.Meeting

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "units" do
    field :name, :string

    has_many :users, User
    has_many :meetings, Meeting

    timestamps()
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
