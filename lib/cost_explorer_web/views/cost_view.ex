defmodule CostExplorerWeb.CostView do
  use CostExplorerWeb, :view
  alias CostExplorerWeb.CostView

  def render("index.json", %{costs: costs}) do
    %{data: render_many(costs, CostView, "cost.json")}
  end

  def render("show.json", %{cost: cost}) do
    %{data: render_one(cost, CostView, "cost.json")}
  end

  def render("cost.json", %{cost: cost}) do
    %{id: cost.id,
      amount: cost.amount}
  end
end
