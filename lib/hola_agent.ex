defmodule Hola.Agente do
    def start_link do
        Agent.start_link(fn -> [] end, name: __MODULE__)
    end

    def traer_todos do
        Agent.get(__MODULE__, fn todos -> todos end)
    end

    def agregar_sala(canal_nombre) do
        m = %{cant_jugadores: 0, jugador1: false, jugador2: false}
        nuevo = put_in([][canal_nombre], m)

        Agent.update(__MODULE__, fn l -> l ++ nuevo end)
    end

    def agregar_jugador(canal_nombre, {:jugador1, jugador_nombre}) do
        todos = Hola.Agente.traer_todos
        c = todos[canal_nombre]
        n = %{ c | jugador1: jugador_nombre, cant_jugadores: c.cant_jugadores + 1}
        todos_n = put_in(todos[canal_nombre], n)
        Agent.update(__MODULE__, fn _l -> todos_n end)
    end

    def agregar_jugador(canal_nombre, {:jugador2, jugador_nombre}) do
        todos = Hola.Agente.traer_todos
        c = todos[canal_nombre]
        n = %{ c | jugador2: jugador_nombre, cant_jugadores: c.cant_jugadores + 1}
        todos_n = put_in(todos[canal_nombre], n)
        Agent.update(__MODULE__, fn _l -> todos_n end)
    end

end
