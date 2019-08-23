defmodule CostExplorer.Directory.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :name, :string

    has_many :projects, CostExplorer.Directory.Project
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
