defmodule Rostrum.Repo.Migrations.AddRolesAndUnit do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, default: "base"
      add :unit_id, references(:units, type: :binary_id)
    end

    create index(:users, [:unit_id])
  end
end
