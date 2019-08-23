defmodule CostExplorer.DirectoryTest do
  use CostExplorer.DataCase

  alias CostExplorer.Directory

  describe "clients" do
    alias CostExplorer.Directory.Client

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Directory.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Directory.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Directory.create_client(@valid_attrs)
      assert client.name == "some name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Directory.update_client(client, @update_attrs)
      assert client.name == "some updated name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_client(client, @invalid_attrs)
      assert client == Directory.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Directory.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Directory.change_client(client)
    end
  end

  describe "projects" do
    alias CostExplorer.Directory.Project

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Directory.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Directory.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Directory.create_project(@valid_attrs)
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Directory.update_project(project, @update_attrs)
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_project(project, @invalid_attrs)
      assert project == Directory.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Directory.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Directory.change_project(project)
    end
  end

  describe "cost_types" do
    alias CostExplorer.Directory.CostType

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def cost_type_fixture(attrs \\ %{}) do
      {:ok, cost_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_cost_type()

      cost_type
    end

    test "list_cost_types/0 returns all cost_types" do
      cost_type = cost_type_fixture()
      assert Directory.list_cost_types() == [cost_type]
    end

    test "get_cost_type!/1 returns the cost_type with given id" do
      cost_type = cost_type_fixture()
      assert Directory.get_cost_type!(cost_type.id) == cost_type
    end

    test "create_cost_type/1 with valid data creates a cost_type" do
      assert {:ok, %CostType{} = cost_type} = Directory.create_cost_type(@valid_attrs)
      assert cost_type.name == "some name"
    end

    test "create_cost_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_cost_type(@invalid_attrs)
    end

    test "update_cost_type/2 with valid data updates the cost_type" do
      cost_type = cost_type_fixture()
      assert {:ok, %CostType{} = cost_type} = Directory.update_cost_type(cost_type, @update_attrs)
      assert cost_type.name == "some updated name"
    end

    test "update_cost_type/2 with invalid data returns error changeset" do
      cost_type = cost_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_cost_type(cost_type, @invalid_attrs)
      assert cost_type == Directory.get_cost_type!(cost_type.id)
    end

    test "delete_cost_type/1 deletes the cost_type" do
      cost_type = cost_type_fixture()
      assert {:ok, %CostType{}} = Directory.delete_cost_type(cost_type)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_cost_type!(cost_type.id) end
    end

    test "change_cost_type/1 returns a cost_type changeset" do
      cost_type = cost_type_fixture()
      assert %Ecto.Changeset{} = Directory.change_cost_type(cost_type)
    end
  end

  describe "costs" do
    alias CostExplorer.Directory.Cost

    @valid_attrs %{amount: "some amount"}
    @update_attrs %{amount: "some updated amount"}
    @invalid_attrs %{amount: nil}

    def cost_fixture(attrs \\ %{}) do
      {:ok, cost} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_cost()

      cost
    end

    test "list_costs/0 returns all costs" do
      cost = cost_fixture()
      assert Directory.list_costs() == [cost]
    end

    test "get_cost!/1 returns the cost with given id" do
      cost = cost_fixture()
      assert Directory.get_cost!(cost.id) == cost
    end

    test "create_cost/1 with valid data creates a cost" do
      assert {:ok, %Cost{} = cost} = Directory.create_cost(@valid_attrs)
      assert cost.amount == "some amount"
    end

    test "create_cost/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_cost(@invalid_attrs)
    end

    test "update_cost/2 with valid data updates the cost" do
      cost = cost_fixture()
      assert {:ok, %Cost{} = cost} = Directory.update_cost(cost, @update_attrs)
      assert cost.amount == "some updated amount"
    end

    test "update_cost/2 with invalid data returns error changeset" do
      cost = cost_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_cost(cost, @invalid_attrs)
      assert cost == Directory.get_cost!(cost.id)
    end

    test "delete_cost/1 deletes the cost" do
      cost = cost_fixture()
      assert {:ok, %Cost{}} = Directory.delete_cost(cost)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_cost!(cost.id) end
    end

    test "change_cost/1 returns a cost changeset" do
      cost = cost_fixture()
      assert %Ecto.Changeset{} = Directory.change_cost(cost)
    end
  end
end
