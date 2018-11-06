defmodule Testfield.Household.Ticket do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tickets" do
    field :message, :string
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:subject, :message])
    |> validate_required([:subject, :message])
  end
end
