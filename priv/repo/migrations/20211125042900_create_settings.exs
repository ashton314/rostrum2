defmodule Rostrum.Repo.Migrations.CreateSettings do
  use Ecto.Migration

  def change do
    create table(:settings) do
      add :active, :boolean, default: false, null: false
      add :public, :boolean, default: false, null: false
      add :contact_email, :string
      add :unit_id, references(:units, on_delete: :nothing)
      add :admin_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:settings, [:unit_id])
    create index(:settings, [:admin_id])
  end
end
