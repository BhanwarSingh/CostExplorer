defmodule CostExplorerWeb.CostController do
  use CostExplorerWeb, :controller

  alias CostExplorer.Directory
  alias CostExplorer.Directory.Cost

  action_fallback CostExplorerWeb.FallbackController

  def index(conn, _params) do
    costs = Directory.list_costs()
    render(conn, "index.json", costs: costs)
  end

  def create(conn, %{"cost" => cost_params}) do
    with {:ok, %Cost{} = cost} <- Directory.create_cost(cost_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cost_path(conn, :show, cost))
      |> render("show.json", cost: cost)
    end
  end

  def show(conn, %{"id" => id}) do
    cost = Directory.get_cost!(id)
    render(conn, "show.json", cost: cost)
  end

  def update(conn, %{"id" => id, "cost" => cost_params}) do
    cost = Directory.get_cost!(id)

    with {:ok, %Cost{} = cost} <- Directory.update_cost(cost, cost_params) do
      render(conn, "show.json", cost: cost)
    end
  end

  def delete(conn, %{"id" => id}) do
    cost = Directory.get_cost!(id)

    with {:ok, %Cost{}} <- Directory.delete_cost(cost) do
      send_resp(conn, :no_content, "")
    end
  end
end
