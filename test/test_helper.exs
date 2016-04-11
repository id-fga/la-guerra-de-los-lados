ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Hola.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Hola.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Hola.Repo)

