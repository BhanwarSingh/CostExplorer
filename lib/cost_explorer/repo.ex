defmodule CostExplorer.Repo do
  use Ecto.Repo,
    otp_app: :cost_explorer,
    adapter: Ecto.Adapters.Postgres
end
