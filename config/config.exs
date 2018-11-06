# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :testfield,
  ecto_repos: [Testfield.Repo]

# Configures the endpoint
config :testfield, TestfieldWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N9kUsEYCkMb3xt3L5Y0h+CnxgsVg6MhA6zJGZ56q/h9FqRMoKfSe/gAzgT9eiiWV",
  render_errors: [view: TestfieldWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Testfield.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
