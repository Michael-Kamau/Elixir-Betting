defmodule Betting.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    has_many :a_matches, Betting.Matches.Match, foreign_key: :team_a_id
    has_many :b_matches, Betting.Matches.Match, foreign_key: :team_b_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
