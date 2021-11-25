defmodule Rostrum.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :date, :naive_datetime
      add :title, :string
      add :unit_id, references(:units, on_delete: :nothing)
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:meetings, [:unit_id])
    create index(:meetings, [:creator_id])
  end
end
