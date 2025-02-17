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
alias Betting.Roles.Role
alias Betting.Accounts.User

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

#Insert default roles
Repo.insert! %Role{
  name: "User",
}

Repo.insert! %Role{
  name: "Admin",
}


#Insert default roles
Repo.insert! %User{
  full_name: "Admin",
  email: "test@gmail.com",
  hashed_password: Bcrypt.hash_pwd_salt("passwordpassword"),
  msisdn: "+254728763522",
  role_id: 2,
  super_user: true,
}
