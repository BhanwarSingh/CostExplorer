defmodule CostExplorerWeb.CostTypeView do
  use CostExplorerWeb, :view
  alias CostExplorerWeb.CostTypeView

  def render("index.json", %{cost_types: cost_types}) do
    %{data: render_many(cost_types, CostTypeView, "cost_type.json")}
  end

  def render("show.json", %{cost_type: cost_type}) do
    %{data: render_one(cost_type, CostTypeView, "cost_type.json")}
  end

  def render("cost_type.json", %{cost_type: cost_type}) do
    %{id: cost_type.id,
      name: cost_type.name}
  end
end
