defmodule BettingWeb.TeamHTML do
  use BettingWeb, :html

  embed_templates "team_html/*"

  @doc """
  Renders a team form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def team_form(assigns)
end
