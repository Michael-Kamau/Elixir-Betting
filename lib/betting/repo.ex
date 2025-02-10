defmodule Betting.Repo do
  use Ecto.Repo,
    otp_app: :betting,
    adapter: Ecto.Adapters.SQLite3
end
