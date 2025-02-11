defmodule BettingWeb.MatchHTML do
  use BettingWeb, :html

  embed_templates "match_html/*"

  @doc """
  Renders a match form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def match_form(assigns)
end
