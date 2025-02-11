defmodule Betting.Odds do
  @moduledoc """
  The Odds context.
  """

  import Ecto.Query, warn: false
  alias Betting.Repo

  alias Betting.Odds.Odd

  @doc """
  Returns the list of odds.

  ## Examples

      iex> list_odds()
      [%Odd{}, ...]

  """
  def list_odds do
    Repo.all(Odd)
  end

  @doc """
  Gets a single odd.

  Raises `Ecto.NoResultsError` if the Odd does not exist.

  ## Examples

      iex> get_odd!(123)
      %Odd{}

      iex> get_odd!(456)
      ** (Ecto.NoResultsError)

  """
  def get_odd!(id), do: Repo.get!(Odd, id)

  @doc """
  Creates a odd.

  ## Examples

      iex> create_odd(%{field: value})
      {:ok, %Odd{}}

      iex> create_odd(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_odd(attrs \\ %{}) do
    %Odd{}
    |> Odd.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a odd.

  ## Examples

      iex> update_odd(odd, %{field: new_value})
      {:ok, %Odd{}}

      iex> update_odd(odd, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_odd(%Odd{} = odd, attrs) do
    odd
    |> Odd.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a odd.

  ## Examples

      iex> delete_odd(odd)
      {:ok, %Odd{}}

      iex> delete_odd(odd)
      {:error, %Ecto.Changeset{}}

  """
  def delete_odd(%Odd{} = odd) do
    Repo.delete(odd)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking odd changes.

  ## Examples

      iex> change_odd(odd)
      %Ecto.Changeset{data: %Odd{}}

  """
  def change_odd(%Odd{} = odd, attrs \\ %{}) do
    Odd.changeset(odd, attrs)
  end
end
