defmodule Betting.Bets.Bet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bets" do
    field :active, :boolean, default: false
    field :bet_amount, :decimal
    field :settled_amount, :decimal
    # field :user_id, :id
    # field :match_id, :id
    # field :odd_id, :id
    belongs_to :user, Betting.Accounts.User
    belongs_to :match, Betting.Matches.Match
    belongs_to :odd, Betting.Odds.Odd


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:bet_amount, :active, :settled_amount])
    |> validate_required([:bet_amount, :active, :settled_amount])
  end
end
