defmodule Betting.Repo.Migrations.CreateTeams do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration


  def change do
    create table(:teams) do
      add :name, :string

      timestamps(type: :utc_datetime)
      soft_delete_columns()

    end
  end
end
