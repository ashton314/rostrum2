defmodule Rostrum.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :order, :integer
      add :type, :string
      add :title, :string
      add :hymn, :integer
      add :participants, :string
      add :note, :string
      add :creator_id, references(:users, on_delete: :nothing)
      add :modifier_id, references(:users, on_delete: :nothing)
      add :meeting_id, references(:meetings, on_delete: :nothing)

      timestamps()
    end

    create index(:events, [:creator_id])
    create index(:events, [:modifier_id])
    create index(:events, [:meeting_id])
  end
end
