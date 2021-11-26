defmodule Rostrum.Repo.Migrations.CreateSettings do
  use Ecto.Migration

  def change do
    create table(:settings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :active, :boolean, default: false, null: false
      add :public, :boolean, default: false, null: false
      add :contact_email, :string
      add :unit_id, references(:units, on_delete: :nothing, type: :binary_id)
      add :admin_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:settings, [:unit_id])
    create index(:settings, [:admin_id])
  end
end
