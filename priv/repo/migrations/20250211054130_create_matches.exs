defmodule Betting.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :team_a_score, :integer
      add :team_b_score, :integer
      add :team_a_id, references(:teams, on_delete: :nothing)
      add :team_b_id, references(:teams, on_delete: :nothing)
      add :odd_id, references(:odds, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:matches, [:team_a_id])
    create index(:matches, [:team_b_id])
    create index(:matches, [:odd_id])
  end
end
