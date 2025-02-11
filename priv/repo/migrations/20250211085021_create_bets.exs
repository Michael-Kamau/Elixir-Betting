defmodule Betting.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :bet_amount, :decimal
      add :active, :boolean, default: false, null: false
      add :settled_amount, :decimal
      add :user_id, references(:users, on_delete: :nothing)
      add :match_id, references(:matches, on_delete: :nothing)
      add :odd_id, references(:odds, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bets, [:user_id])
    create index(:bets, [:match_id])
    create index(:bets, [:odd_id])
  end
end
