defmodule CostExplorerWeb.CostControllerTest do
  use CostExplorerWeb.ConnCase

  alias CostExplorer.Directory
  alias CostExplorer.Directory.Cost

  @create_attrs %{
    amount: "some amount"
  }
  @update_attrs %{
    amount: "some updated amount"
  }
  @invalid_attrs %{amount: nil}

  def fixture(:cost) do
    {:ok, cost} = Directory.create_cost(@create_attrs)
    cost
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all costs", %{conn: conn} do
      conn = get(conn, Routes.cost_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cost" do
    test "renders cost when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cost_path(conn, :create), cost: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.cost_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => "some amount"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cost_path(conn, :create), cost: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cost" do
    setup [:create_cost]

    test "renders cost when data is valid", %{conn: conn, cost: %Cost{id: id} = cost} do
      conn = put(conn, Routes.cost_path(conn, :update, cost), cost: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.cost_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => "some updated amount"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cost: cost} do
      conn = put(conn, Routes.cost_path(conn, :update, cost), cost: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cost" do
    setup [:create_cost]

    test "deletes chosen cost", %{conn: conn, cost: cost} do
      conn = delete(conn, Routes.cost_path(conn, :delete, cost))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.cost_path(conn, :show, cost))
      end
    end
  end

  defp create_cost(_) do
    cost = fixture(:cost)
    {:ok, cost: cost}
  end
end
