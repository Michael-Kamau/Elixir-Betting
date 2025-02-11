defmodule Betting.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :team_a_score, :integer
    field :team_b_score, :integer
    field :team_a_id, :id
    field :team_b_id, :id
    field :odd_id, :id
    has_many :odds, Betting.Odds.Odd


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:team_a_id, :team_b_id, :team_a_score, :team_b_score])
    |> validate_required([:team_a_id, :team_b_id,  :team_a_score, :team_b_score])
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
