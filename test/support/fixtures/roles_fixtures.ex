defmodule Betting.RolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betting.Roles` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Betting.Roles.create_role()

    role
  end
end
