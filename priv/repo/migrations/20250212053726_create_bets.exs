defmodule Betting.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :bet_amount, :decimal
      add :cancelled, :boolean, default: false, null: false
      add :settled_amount, :decimal
      add :user_id, references(:users, on_delete: :nothing)
      add :match_id, references(:matches, on_delete: :nothing)
      add :outcome_id, references(:outcomes, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bets, [:user_id])
    create index(:bets, [:match_id])
    create index(:bets, [:outcome_id])
  end
end
