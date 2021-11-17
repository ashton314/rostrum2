defmodule Rostrum.Repo.Migrations.AddRolesAndUnit do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, default: "base"
      add :unit_id, references(:units)
    end

    create index("user_unit_id", [:unit_id])
  end
end
