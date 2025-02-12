defmodule Betting.Outcomes do
  @moduledoc """
  The Outcomes context.
  """

  import Ecto.Query, warn: false
  alias Betting.Repo

  alias Betting.Outcomes.Outcome

  @doc """
  Returns the list of Outcomes.

  ## Examples

      iex> list_outcomes()
      [%Outcome{}, ...]

  """
  def list_outcomes do
    Repo.all(Outcome)
  end

  @doc """
  Gets a single outcome.

  Raises `Ecto.NoResultsError` if the Outcome does not exist.

  ## Examples

      iex> get_outcome!(123)
      %Outcome{}

      iex> get_outcome!(456)
      ** (Ecto.NoResultsError)

  """
  def get_outcome!(id), do: Repo.get!(Outcome, id)

  @doc """
  Creates a outcome.

  ## Examples

      iex> create_outcome(%{field: value})
      {:ok, %Outcome{}}

      iex> create_outcome(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_outcome(attrs \\ %{}) do
    %Outcome{}
    |> Outcome.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a outcome.

  ## Examples

      iex> update_outcome(outcome, %{field: new_value})
      {:ok, %Outcome{}}

      iex> update_outcome(outcome, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_outcome(%Outcome{} = outcome, attrs) do
    outcome
    |> Outcome.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a outcome.

  ## Examples

      iex> delete_outcome(outcome)
      {:ok, %Outcome{}}

      iex> delete_outcome(outcome)
      {:error, %Ecto.Changeset{}}

  """
  def delete_outcome(%Outcome{} = outcome) do
    Repo.delete(outcome)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking outcome changes.

  ## Examples

      iex> change_outcome(outcome)
      %Ecto.Changeset{data: %Outcome{}}

  """
  def change_outcome(%Outcome{} = outcome, attrs \\ %{}) do
    Outcome.changeset(outcome, attrs)
  end
end
