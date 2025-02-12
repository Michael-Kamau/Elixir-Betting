defmodule BettingWeb.HomepageLive do
  use BettingWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="w-full h-full bg-gray-800 px-2">
      <section class=" text-white">
        <div class="container mx-auto py-12">
          <h1 class="text-4xl font-bold text-center">Welcome to BetMaster</h1>
          <p class="text-xl text-center mt-4">The ultimate online betting platform</p>
        </div>
      </section>

      <section class="overflow-x-auto bg-gray-800 rounded-lg shadow-lg">
        <table class="min-w-full table-auto text-left text-sm text-gray-300">
          <thead class="bg-gray-700">
            <tr>
              <th class="px-6 py-3">Match</th>
              <th class="px-6 py-3">Scores</th>
              <th class="px-6 py-3">Team A Odds</th>
              <th class="px-6 py-3">Draw Odds</th>
              <th class="px-6 py-3">Team B Odds</th>
              <th class="px-6 py-3">Place Bet</th>
            </tr>
          </thead>
          <tbody>
            <%= for match <- @matches do %>
              <tr class="border-t border-gray-600">
                <td class="px-6 py-4">{match.team_a.name} vs {match.team_b.name}</td>
                <td class="px-6 py-4">({match.team_a_score} - {match.team_b_score})</td>
                <td class="px-6 py-4">{match.team_a_odd}</td>
                <td class="px-6 py-4">{match.team_b_odd}</td>
                <td class="px-6 py-4">{match.draw_odd}</td>
                <td class="px-6 py-4">
                  <.link patch={~p"/bets/new/#{match.id}"}>
                    <button
                      class="bg-yellow-500 text-gray-900 px-4 py-2 rounded-lg hover:bg-yellow-600 transition"
                    >
                      Place Bet
                    </button>
                  </.link>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </section>
    </div>

    <.modal id="user-modal">
      <div>This is the modal</div>
      <button phx-click={hide_modal("user-modal")}>Click me</button>
    </.modal>
    """
  end

  def mount(_params, _session, socket) do
    # Let's assume a fixed temperature for now
    matches = Betting.Matches.list_matches()
    {:ok, assign(socket, :matches, matches)}
  end

  @spec handle_event(<<_::120>>, any(), map()) :: {:noreply, map()}
  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end
end
