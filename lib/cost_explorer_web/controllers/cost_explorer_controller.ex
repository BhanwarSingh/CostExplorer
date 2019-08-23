defmodule CostExplorerWeb.CostExplorerController do
  use CostExplorerWeb, :controller

  import Ecto.Query

  alias CostExplorer.Repo
  alias CostExplorer.Directory.{Client, Cost, CostType, Project}

  action_fallback CostExplorerWeb.FallbackController

  def index(conn, _params) do
    text conn, "CostExplorer!"
  end

  def cost_explorer_index(conn, params) do
    cost_data = get_cost_data!(params)

    json(conn, cost_data)
  end

  def get_cost_data!(params) do
    clients =
      if params["clients"] do
        query = from(c in Client, where: c.id in ^params["clients"])

        Repo.all(query)
      else
        Client |> Repo.all
      end

    Enum.map(clients, fn client ->
      client
      |> Map.take(client_fields)
      |> Map.merge(total_cost_per_client(client))
      |> Map.merge(project_fields(client, params))
    end)
  end

  defp client_fields, do: [:id, :name]

  defp total_cost_per_client(client) do
    query =
      from(
        co in Cost,
        join: ct in assoc(co, :cost_type),
        join: pro in assoc(co, :project),
        join: cl in assoc(pro, :client),
        select: type(co.amount, :integer),
        where: cl.id == ^client.id and is_nil(ct.parent_cost_type_id)
      )

    get_cost_amount(query)
  end

  defp project_fields(client, params) do
    query =
      if params["projects"] do
        from(p in Project, where: p.client_id == ^client.id and p.id in ^params["projects"])
      else
        from(p in Project, where: p.client_id == ^client.id)
      end

    projects = Repo.all(query)

    %{
      breakdown:
      Enum.map(projects, fn project ->
        Map.take(project, [
          :id,
          :title
        ])
        |> Map.merge(total_cost_per_project(project))
        |> Map.merge(cost_type_fields(project, params))
      end)
    }
  end

  defp total_cost_per_project(project) do
    query =
      from(
        co in Cost,
        join: ct in assoc(co, :cost_type),
        select: type(co.amount, :integer),
        where: co.project_id == ^project.id and is_nil(ct.parent_cost_type_id)
      )

    get_cost_amount(query)
  end

  defp cost_type_fields(project, params) do
    query =
      if params["cost_types"] do
        from(
          ct in CostType,
          where: is_nil(ct.parent_cost_type_id)
            and ct.id in ^params["cost_types"]
        )
      else
        from(
          ct in CostType,
          where: is_nil(ct.parent_cost_type_id)
        )
      end

    parent_cost_types = Repo.all(query)

    %{
      breakdown:
      Enum.map(parent_cost_types, fn cost_type ->
        Map.take(cost_type, [
          :id,
          :name
        ])
        |> Map.merge(total_cost_per_type(cost_type, project))
        |> Map.merge(cost_fields(cost_type, project))
      end)
    }
  end

  defp total_cost_per_type(cost_type, project) do
    # {:ok, child_cost_type_ids} =
    #   Repo.query(
    #     "WITH RECURSIVE rec_tree(id, name, parent_cost_type_id) AS
    #       (SELECT t.id, t.name, t.parent_cost_type_id
    #         FROM cost_types t
    #         where t.id = #{cost_type.id}
    #       UNION ALL
    #       SELECT t.id, t.name, t.parent_cost_type_id
    #         FROM cost_types t, rec_tree rt
    #         WHERE t.parent_cost_type_id = rt.id
    #     ) SELECT id, name FROM rec_tree"
    #   )

    # child_cost_type_ids =
    #   child_cost_type_ids.rows
    #   |> Enum.map(fn x -> hd(x) end)

    # query =
    #   from(
    #     co in Cost,
    #     join: ct in assoc(co, :cost_type),
    #     select: type(co.amount, :integer),
    #     where: co.project_id == ^project.id
    #       and (ct.id in ^child_cost_type_ids
    #         or ct.parent_cost_type_id in ^child_cost_type_ids)
    #   )

    query =
      from(
        co in Cost,
        join: ct in assoc(co, :cost_type),
        select: type(co.amount, :integer),
        where: co.project_id == ^project.id and ct.id == ^cost_type.id
      )

    get_cost_amount(query)
  end

  defp cost_fields(cost_type, project) do
    cost_type = cost_type |> Repo.preload(:child_cost_types)

    %{
      breakdown:
      Enum.map(cost_type.child_cost_types, fn cost_type ->
        Map.take(cost_type, [
          :id,
          :name
        ])
        |> Map.merge(total_cost_per_type(cost_type, project))
        |> Map.merge(cost_fields(cost_type, project))
      end)
    }
  end

  defp get_cost_amount(query) do
    cost_amount = Repo.all(query)

    %{"amount": Enum.sum(cost_amount)}
  end
end
