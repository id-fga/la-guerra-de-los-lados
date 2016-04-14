ExUnit.start

Mix.Task.run "ecto.create", ~w(-r LaGuerraDeLosLados.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r LaGuerraDeLosLados.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(LaGuerraDeLosLados.Repo)

