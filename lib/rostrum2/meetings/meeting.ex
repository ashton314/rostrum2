defmodule Rostrum.Meetings.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meetings" do
    field :date, :naive_datetime
    field :title, :string
    field :unit_id, :id
    field :creator_id, :id

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :title])
    |> validate_required([:date, :title])
  end
end
