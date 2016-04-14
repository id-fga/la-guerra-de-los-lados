use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :la_guerra_de_los_lados, LaGuerraDeLosLados.Endpoint,
  secret_key_base: "OYlGtLmHOy5HwMZl0r9eNCjrr74ROauRyVZcqESLPvm9cA0m4DQZfZx1bYSL4PIe"

# Configure your database
config :la_guerra_de_los_lados, LaGuerraDeLosLados.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "la_guerra_de_los_lados_prod",
  pool_size: 20
