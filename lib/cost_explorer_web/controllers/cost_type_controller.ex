defmodule CostExplorerWeb.CostTypeController do
  use CostExplorerWeb, :controller

  alias CostExplorer.Directory
  alias CostExplorer.Directory.CostType

  action_fallback CostExplorerWeb.FallbackController

  def index(conn, _params) do
    cost_types = Directory.list_cost_types()
    render(conn, "index.json", cost_types: cost_types)
  end

  def create(conn, %{"cost_type" => cost_type_params}) do
    with {:ok, %CostType{} = cost_type} <- Directory.create_cost_type(cost_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cost_type_path(conn, :show, cost_type))
      |> render("show.json", cost_type: cost_type)
    end
  end

  def show(conn, %{"id" => id}) do
    cost_type = Directory.get_cost_type!(id)
    render(conn, "show.json", cost_type: cost_type)
  end

  def update(conn, %{"id" => id, "cost_type" => cost_type_params}) do
    cost_type = Directory.get_cost_type!(id)

    with {:ok, %CostType{} = cost_type} <- Directory.update_cost_type(cost_type, cost_type_params) do
      render(conn, "show.json", cost_type: cost_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    cost_type = Directory.get_cost_type!(id)

    with {:ok, %CostType{}} <- Directory.delete_cost_type(cost_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
