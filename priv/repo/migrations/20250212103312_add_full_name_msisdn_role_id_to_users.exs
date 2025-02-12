defmodule Betting.Repo.Migrations.AddFullNameMsisdnRoleIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :full_name, :string
      add :super_user, :boolean, default: false
      add :msisdn, :string
      add :role_id, references(:roles, on_delete: :nothing), default: 1
    end

    create unique_index(:users, [:msisdn])
  end
end
