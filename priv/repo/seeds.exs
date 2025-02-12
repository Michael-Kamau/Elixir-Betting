# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Betting.Repo.insert!(%Betting.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Betting.Repo
alias Betting.Categories.Category
alias Betting.Outcomes.Outcome
alias Betting.Teams.Team

Repo.insert! %Category{
  name: "Football",
}

Repo.insert! %Outcome{
  name: "Team A Wins",
}

Repo.insert! %Outcome{
  name: "Team B Wins",
}

Repo.insert! %Outcome{
  name: "Draw",
}


Repo.insert! %Team{
  name: "Manchester United",
}

Repo.insert! %Team{
  name: "Manchester City",
}

Repo.insert! %Team{
  name: "Liverpool",
}

Repo.insert! %Team{
  name: "Arsenal",
}

Repo.insert! %Team{
  name: "Chelsea",
}
