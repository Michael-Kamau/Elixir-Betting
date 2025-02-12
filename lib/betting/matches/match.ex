defmodule Betting.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema


  schema "matches" do
    field :team_a_score, :integer
    field :team_b_score, :integer
    field :team_a_odd, :float
    field :team_b_odd, :float
    field :draw_odd, :float
    belongs_to :category, Betting.Categories.Category
    belongs_to :team_a, Betting.Teams.Team
    belongs_to :team_b, Betting.Teams.Team
    belongs_to :outcome, Betting.Outcomes.Outcome
    has_many :bets, Betting.Bets.Bet


    timestamps(type: :utc_datetime)
    soft_delete_schema()

  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:team_a_score, :team_b_score, :team_a_id, :team_b_id, :category_id, :team_a_odd, :team_b_odd, :draw_odd])
    |> validate_required([:team_a_score, :team_b_score, :team_a_id, :team_b_id, :category_id, :team_a_odd, :team_b_odd, :draw_odd])
    |> validate_team_ids_unique()
  end

  defp validate_team_ids_unique(changeset) do
    team_a_id = get_field(changeset, :team_a_id)
    team_b_id = get_field(changeset, :team_b_id)

    if team_a_id == team_b_id do
      add_error(changeset, :team_b_id, "Team A and Team B cannot be the same")
    else
      changeset
    end
  end
end
