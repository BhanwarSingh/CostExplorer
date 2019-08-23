defmodule CostExplorer.Repo.Migrations.CreateCostTypes do
  use Ecto.Migration

  def change do
    create table(:cost_types) do
      add :name, :string
      add :parent_cost_type_id, references(:cost_types, on_delete: :nothing)

      timestamps()
    end

    create index(:cost_types, [:parent_cost_type_id])
  end
end
