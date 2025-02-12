defmodule Betting.Repo.Migrations.CreateRoles do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:roles) do
      add :name, :string

      timestamps(type: :utc_datetime)
      soft_delete_columns()

    end
  end
end
