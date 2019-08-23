defmodule CostExplorerWeb.Router do
  use CostExplorerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CostExplorerWeb do
    pipe_through :api
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", CostExplorerWeb do
    pipe_through :browser
    get "/", CostExplorerController, :index
    get "/cost-explorer", CostExplorerController, :cost_explorer_index
  end
end
