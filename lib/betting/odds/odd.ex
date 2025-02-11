defmodule Betting.Odds.Odd do
  use Ecto.Schema
  import Ecto.Changeset

  schema "odds" do
    field :outcome,  Ecto.Enum, values: [:team_a_win, :team_b_win, :draw]
    field :odd_value, :float
    belongs_to :match, Betting.Matches.Match
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(odd, attrs) do
    odd
    |> cast(attrs, [:outcome, :odd_value])
    |> validate_required([:outcome, :odd_value])
  end
end
