# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the namespace used by Phoenix generators
config :json_dog,
  app_namespace: Dog

# Configures the endpoint
config :json_dog, Dog.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "oWB//SNmrUw5KNlTBhyiNvLWJLAZaGPbYzubspSH4jAiQihmY5w9VYShBx+fprZZ",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: Dog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
