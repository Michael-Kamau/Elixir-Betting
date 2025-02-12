defmodule Betting.Repo.Migrations.CreateOutcomes do
  use Ecto.Migration

  def change do
    create table(:outcomes) do
      add :name, :string


      timestamps(type: :utc_datetime)
    end
  end
end
