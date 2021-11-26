defmodule Rostrum.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :order, :integer
      add :type, :string
      add :title, :string
      add :hymn, :integer
      add :participants, :string
      add :note, :string
      add :creator_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :modifier_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :meeting_id, references(:meetings, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:events, [:creator_id])
    create index(:events, [:modifier_id])
    create index(:events, [:meeting_id])
  end
end
