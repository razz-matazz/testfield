defmodule Testfield.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :subject, :string
      add :message, :text

      timestamps()
    end

  end
end
