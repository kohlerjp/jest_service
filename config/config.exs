# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jest_service,
  ecto_repos: [JestService.Repo]

# Configures the endpoint
config :jest_service, JestServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mf7ejZYtZV9Ky3fKc9zp8hSlN6xSpeHmYnoRXGBTwyHaQi1gAXlyH+4ZPM6Ue+cF",
  render_errors: [view: JestServiceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: JestService.PubSub,
  live_view: [signing_salt: "GdgCHfxy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
