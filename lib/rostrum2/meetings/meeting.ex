defmodule Rostrum.Meetings.Meeting do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rostrum.Accounts.Unit

  schema "meetings" do
    field :date, :naive_datetime
    field :title, :string
    field :creator_id, :id

    belongs_to :unit, Unit

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :title])
    |> cast_assoc(:unit, with: &Unit.changeset/2)
    |> validate_required([:date, :title])
  end
end
