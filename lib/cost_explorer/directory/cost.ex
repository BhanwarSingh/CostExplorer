defmodule CostExplorer.Directory.Cost do
  use Ecto.Schema
  import Ecto.Changeset

  schema "costs" do
    field :amount, :string

    belongs_to :cost_type, CostExplorer.Directory.CostType
    belongs_to :project, CostExplorer.Directory.Project
  end

  @doc false
  def changeset(cost, attrs) do
    cost
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
