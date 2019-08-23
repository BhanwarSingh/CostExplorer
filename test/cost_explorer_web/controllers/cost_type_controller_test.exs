defmodule CostExplorerWeb.CostTypeControllerTest do
  use CostExplorerWeb.ConnCase

  alias CostExplorer.Directory
  alias CostExplorer.Directory.CostType

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:cost_type) do
    {:ok, cost_type} = Directory.create_cost_type(@create_attrs)
    cost_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cost_types", %{conn: conn} do
      conn = get(conn, Routes.cost_type_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cost_type" do
    test "renders cost_type when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cost_type_path(conn, :create), cost_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.cost_type_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cost_type_path(conn, :create), cost_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cost_type" do
    setup [:create_cost_type]

    test "renders cost_type when data is valid", %{conn: conn, cost_type: %CostType{id: id} = cost_type} do
      conn = put(conn, Routes.cost_type_path(conn, :update, cost_type), cost_type: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.cost_type_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cost_type: cost_type} do
      conn = put(conn, Routes.cost_type_path(conn, :update, cost_type), cost_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cost_type" do
    setup [:create_cost_type]

    test "deletes chosen cost_type", %{conn: conn, cost_type: cost_type} do
      conn = delete(conn, Routes.cost_type_path(conn, :delete, cost_type))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.cost_type_path(conn, :show, cost_type))
      end
    end
  end

  defp create_cost_type(_) do
    cost_type = fixture(:cost_type)
    {:ok, cost_type: cost_type}
  end
end
