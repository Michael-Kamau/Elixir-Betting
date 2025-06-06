defmodule Betting.Repo.Migrations.CreateMatches do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:matches) do
      add :team_a_score, :integer
      add :team_b_score, :integer
      add :team_a_id, references(:teams, on_delete: :nothing)
      add :team_b_id, references(:teams, on_delete: :nothing)
      add :team_a_odd, :float
      add :team_b_odd, :float
      add :draw_odd, :float
      add :outcome_id, references(:outcomes, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps(type: :utc_datetime)
      soft_delete_columns()

    end

    create index(:matches, [:team_a_id])
    create index(:matches, [:team_b_id])
    create index(:matches, [:outcome_id])
    create index(:matches, [:category_id])
  end
end
