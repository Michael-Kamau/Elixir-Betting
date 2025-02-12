defmodule Betting.Outcomes.Outcome do
  use Ecto.Schema
  import Ecto.Changeset

  schema "outcomes" do
    field :name, :string
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(outcome, attrs) do
    outcome
    |> cast(attrs, [:name])
    |> validate_required([:name])

  end
end
