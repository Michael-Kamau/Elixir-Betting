defmodule Betting.Matches.MatchNotifier do
  import Swoosh.Email

  alias Betting.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"Betting", "contact@example.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end



  def bet_settled_notification(bet, match) do
    if bet.outcome_id == match.outcome_id do
      notify_winner(bet, match)
    else
      notify_loser(bet, match)
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  defp notify_winner(bet, match) do
    deliver(bet.user.email, "You have won", """

    ==============================

    Hi #{bet.user.email},

    Congratulations!

    Your bet on #{match.team_a.name} vs #{match.team_b.name} has won.

    The amount won from your bet is #{bet.settled_amount}.

    ==============================
    """)
  end

  defp notify_loser(bet, match) do
    deliver(bet.user.email, "You have lost", """

    ==============================

    Hi #{bet.user.email},

    Your bet on #{match.team_a.name} vs #{match.team_b.name} has lost.

    The amount lost from your bet is #{bet.settled_amount}.

    Better luck next time.

    ==============================
    """)
  end


end
