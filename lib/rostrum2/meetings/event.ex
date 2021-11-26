defmodule Rostrum.Meetings.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :hymn, :integer
    field :note, :string
    field :order, :integer
    field :participants, :string
    field :title, :string
    field :type, Ecto.Enum, values: [:hymn, :musical_number, :talk, :ordinance, :note]
    field :creator_id, :id
    field :modifier_id, :id
    field :meeting_id, :id

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:order, :type, :title, :hymn, :participants, :note])
    |> validate_required([:order, :type, :title, :hymn, :participants, :note])
  end
end
