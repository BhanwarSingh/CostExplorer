defmodule CostExplorer.Repo.Migrations.CreateCosts do
  use Ecto.Migration

  def change do
    create table(:costs) do
      add :amount, :string
      add :cost_type_id, references(:cost_types, on_delete: :nothing)
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:costs, [:cost_type_id])
    create index(:costs, [:project_id])
  end
end
