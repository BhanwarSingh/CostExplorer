defmodule CostExplorer.Directory.CostType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cost_types" do
    field :name, :string

    belongs_to :parent_cost_type, CostExplorer.Directory.CostType
    has_many :child_cost_types, CostExplorer.Directory.CostType, foreign_key: :parent_cost_type_id
  end

  @doc false
  def changeset(cost_type, attrs) do
    cost_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
