use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :la_guerra_de_los_lados, LaGuerraDeLosLados.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :la_guerra_de_los_lados, LaGuerraDeLosLados.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "la_guerra_de_los_lados_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
