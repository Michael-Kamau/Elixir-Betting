defmodule Betting.Repo.Migrations.CreateOdds do
  use Ecto.Migration

  def change do
    create table(:odds) do
      add :outcome, :string
      add :value, :float
      add :match_id, references(:matches, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:odds, [:match_id])
  end
end
