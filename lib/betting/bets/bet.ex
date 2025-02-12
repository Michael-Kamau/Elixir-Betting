defmodule Betting.Bets.Bet do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  schema "bets" do
    field :cancelled, :boolean, default: false
    field :bet_amount, :decimal
    field :settled_amount, :decimal
    # field :user_id, :id
    # field :match_id, :id
    # field :outcome_id, :id
    belongs_to :user, Betting.Accounts.User
    belongs_to :match, Betting.Matches.Match
    belongs_to :outcome, Betting.Outcomes.Outcome

    timestamps(type: :utc_datetime)
    soft_delete_schema()

  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:bet_amount, :cancelled, :user_id, :match_id, :settled_amount, :outcome_id])
    |> validate_required([:bet_amount, :cancelled, :user_id, :match_id, :outcome_id])
  end
end
