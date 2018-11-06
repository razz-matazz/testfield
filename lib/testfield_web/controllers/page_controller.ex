defmodule TestfieldWeb.PageController do
  use TestfieldWeb, :controller
  alias Testfield.Repo
  alias Testfield.Household.Ticket
  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset, only: [change: 2]

  @paging_factor 5

  def generate_repo() do
    Enum.each(0..99, fn(x) ->
      params = %{
        subject: "test",
        message: to_string(x)
      }
      Ticket.changeset(%Ticket{}, params)
      |> Repo.insert()
    end)
  end


  def index(conn, _params) do

    # generate_repo()

    query = from t in Ticket,
              order_by: t.subject

    # page = paginate(query, conn.params["cursor_after"], conn.params["cursor_before"])

    # return the first 5 posts
    page1 = Repo.paginate(query, cursor_fields: [:subject, :id], limit: @paging_factor)
    IO.puts "First 5:"
    for item <- page1.entries do
      IO.puts item.message
    end

    # assign the `after` cursor to a variable
    cursor_after = page1.metadata.after

    # return the next 5 posts
    page2 = Repo.paginate(query, after: cursor_after, cursor_fields: [:subject, :id], limit: @paging_factor)
    IO.puts "Next 5..."
    for item <- page2.entries do
      IO.puts item.message
    end

    # assign the `before` cursor to a variable
    cursor_before = page2.metadata.before

    # return the previous 5 posts (if no post was created in between it should be the same list as in our first call to `paginate`)
    page3 = Repo.paginate(query, before: cursor_before, cursor_fields: [:subject, :id], limit: @paging_factor)
    IO.puts "Back to first 5..."
    for item <- page3.entries do
      IO.puts item.message
    end

    IO.puts "Compare first und last entries:"
    check = MapSet.new(page3.entries) |> MapSet.subset?(MapSet.new(page1.entries))
    IO.puts check

    render conn, "index.html", collection: page1.entries, metadata: page1.metadata
  end
end
