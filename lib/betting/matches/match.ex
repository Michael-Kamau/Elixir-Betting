defmodule Betting.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :team_a_score, :integer
    field :team_b_score, :integer
    field :team_a_id, :id
    field :team_b_id, :id
    field :odd_id, :id
    belongs_to :category, Betting.Categories.Category
    belongs_to :team, Betting.Teams.Team

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:team_a_score, :team_b_score])
    |> validate_required([:team_a_score, :team_b_score])
  end
end
