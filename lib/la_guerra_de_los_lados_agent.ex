defmodule LaGuerraDeLosLados.Agent do
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def traer_salas do
    Agent.get(__MODULE__, fn todos -> todos end)
  end

  def traer_sala(sala) do
    Agent.get(__MODULE__, fn todos -> Map.get(todos, sala) end)
  end

  def agregar_sala(sala) do
    Agent.update(__MODULE__, fn todos -> Map.put(todos, sala, []) end)
  end

  def agregar_respuesta(sala, jugador_numero, jugador_respuesta) do
    s = traer_sala(sala)
    ns = s ++ [{jugador_numero, jugador_respuesta}]
    Agent.update(__MODULE__, fn todos -> Map.put(todos, sala, ns) end)
  end

  def vaciar_respuestas(sala) do
    Agent.update(__MODULE__, fn todos -> Map.put(todos, sala, []) end)
  end


end
