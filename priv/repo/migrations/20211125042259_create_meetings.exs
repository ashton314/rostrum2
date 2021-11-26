defmodule Rostrum.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :naive_datetime
      add :title, :string
      add :unit_id, references(:units, on_delete: :nothing, type: :binary_id)
      add :creator_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:meetings, [:unit_id])
    create index(:meetings, [:creator_id])
  end
end
