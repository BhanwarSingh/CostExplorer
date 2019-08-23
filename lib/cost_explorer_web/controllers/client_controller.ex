defmodule CostExplorerWeb.ClientController do
  use CostExplorerWeb, :controller

  alias CostExplorer.Directory
  alias CostExplorer.Directory.Client

  action_fallback CostExplorerWeb.FallbackController

  def index(conn, _params) do
    clients = Directory.list_clients()
    render(conn, "index.json", clients: clients)
  end

  def create(conn, %{"client" => client_params}) do
    with {:ok, %Client{} = client} <- Directory.create_client(client_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.client_path(conn, :show, client))
      |> render("show.json", client: client)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Directory.get_client!(id)
    render(conn, "show.json", client: client)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Directory.get_client!(id)

    with {:ok, %Client{} = client} <- Directory.update_client(client, client_params) do
      render(conn, "show.json", client: client)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Directory.get_client!(id)

    with {:ok, %Client{}} <- Directory.delete_client(client) do
      send_resp(conn, :no_content, "")
    end
  end
end
