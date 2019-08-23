defmodule CostExplorer.Directory do
  @moduledoc """
  The Directory context.
  """

  import Ecto.Query, warn: false
  alias CostExplorer.Repo

  alias CostExplorer.Directory.Client

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients do
    Repo.all(Client)
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id), do: Repo.get!(Client, id)

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{source: %Client{}}

  """
  def change_client(%Client{} = client) do
    Client.changeset(client, %{})
  end

  alias CostExplorer.Directory.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{source: %Project{}}

  """
  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end

  alias CostExplorer.Directory.CostType

  @doc """
  Returns the list of cost_types.

  ## Examples

      iex> list_cost_types()
      [%CostType{}, ...]

  """
  def list_cost_types do
    Repo.all(CostType)
  end

  @doc """
  Gets a single cost_type.

  Raises `Ecto.NoResultsError` if the Cost type does not exist.

  ## Examples

      iex> get_cost_type!(123)
      %CostType{}

      iex> get_cost_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cost_type!(id), do: Repo.get!(CostType, id)

  @doc """
  Creates a cost_type.

  ## Examples

      iex> create_cost_type(%{field: value})
      {:ok, %CostType{}}

      iex> create_cost_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cost_type(attrs \\ %{}) do
    %CostType{}
    |> CostType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cost_type.

  ## Examples

      iex> update_cost_type(cost_type, %{field: new_value})
      {:ok, %CostType{}}

      iex> update_cost_type(cost_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cost_type(%CostType{} = cost_type, attrs) do
    cost_type
    |> CostType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CostType.

  ## Examples

      iex> delete_cost_type(cost_type)
      {:ok, %CostType{}}

      iex> delete_cost_type(cost_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cost_type(%CostType{} = cost_type) do
    Repo.delete(cost_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cost_type changes.

  ## Examples

      iex> change_cost_type(cost_type)
      %Ecto.Changeset{source: %CostType{}}

  """
  def change_cost_type(%CostType{} = cost_type) do
    CostType.changeset(cost_type, %{})
  end

  alias CostExplorer.Directory.Cost

  @doc """
  Returns the list of costs.

  ## Examples

      iex> list_costs()
      [%Cost{}, ...]

  """
  def list_costs do
    Repo.all(Cost)
  end

  @doc """
  Gets a single cost.

  Raises `Ecto.NoResultsError` if the Cost does not exist.

  ## Examples

      iex> get_cost!(123)
      %Cost{}

      iex> get_cost!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cost!(id), do: Repo.get!(Cost, id)

  @doc """
  Creates a cost.

  ## Examples

      iex> create_cost(%{field: value})
      {:ok, %Cost{}}

      iex> create_cost(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cost(attrs \\ %{}) do
    %Cost{}
    |> Cost.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cost.

  ## Examples

      iex> update_cost(cost, %{field: new_value})
      {:ok, %Cost{}}

      iex> update_cost(cost, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cost(%Cost{} = cost, attrs) do
    cost
    |> Cost.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Cost.

  ## Examples

      iex> delete_cost(cost)
      {:ok, %Cost{}}

      iex> delete_cost(cost)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cost(%Cost{} = cost) do
    Repo.delete(cost)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cost changes.

  ## Examples

      iex> change_cost(cost)
      %Ecto.Changeset{source: %Cost{}}

  """
  def change_cost(%Cost{} = cost) do
    Cost.changeset(cost, %{})
  end
end
