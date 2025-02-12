defmodule Betting.Repo.Migrations.CreateCategories do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:categories) do
      add :name, :string


      timestamps(type: :utc_datetime)
      soft_delete_columns()
    end

    create unique_index(:categories, [:name])
  end
end
