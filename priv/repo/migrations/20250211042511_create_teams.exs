defmodule Betting.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string,


      timestamps(type: :utc_datetime)
    end

    create unique_index(:categories, [:name])
  end
end
