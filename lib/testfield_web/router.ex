defmodule TestfieldWeb.Router do
  use TestfieldWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestfieldWeb do
    pipe_through :browser # Use the default browser stack
    resources "/tickets", TicketController
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestfieldWeb do
  #   pipe_through :api
  # end
end
