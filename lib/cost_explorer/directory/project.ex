defmodule CostExplorer.Directory.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :title, :string

    belongs_to :client, CostExplorer.Directory.Client
    has_many :costs, CostExplorer.Directory.Cost
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
