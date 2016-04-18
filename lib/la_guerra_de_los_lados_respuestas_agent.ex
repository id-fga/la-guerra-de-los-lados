defmodule LaGuerraDeLosLados.Respuestas do
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def traer_sala(sala) do
    Agent.get(__MODULE__, fn todos -> Map.get(todos, sala) end)
  end

  def agregar_sala(sala) do
    Agent.update(__MODULE__, fn todos -> Map.put(todos, sala, []) end)
  end

  def agregar_respuestas(sala, respuestas) do
    s = traer_sala(sala)
    ns = s ++ [respuestas]
    Agent.update(__MODULE__, fn todos -> Map.put(todos, sala, ns) end)
  end

end
