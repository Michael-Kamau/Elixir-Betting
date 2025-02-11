defmodule Betting.Odds.Odd do
  use Ecto.Schema
  import Ecto.Changeset

  schema "odds" do
    field :value, :float
    field :outcome, :string
    belongs_to :match, Betting.Matches.Match

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(odd, attrs) do
    odd
    |> cast(attrs, [:outcome, :value])
    |> validate_required([:outcome, :value])
  end
end
