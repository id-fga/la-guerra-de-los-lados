defmodule LaGuerraDeLosLados.Respuestas do
  def start_link do
    Agent.start_link(fn-> %{} end, name: __MODULE__)
  end
  
  def crear_sala(sala_nombre) do
    mapa = %{
              jugador1: "",
              jugador2: "",
              puntaje_jugador1: 0,
              puntaje_jugador2: 0,
              guerra: 0,
              respuestas: []
    }

    Agent.update(__MODULE__, fn todas -> Map.put(todas, sala_nombre, mapa) end)
  end

  def agregar_jugador(sala_nombre, numero_jugador, nombre_jugador) do
    todas = traer_todas
    sala_actual = Map.get(todas, sala_nombre)


    nueva_info = case numero_jugador do
      "jugador1"  ->  nueva_info = %{ sala_actual | jugador1: nombre_jugador }

      "jugador2"  ->  nueva_info = %{ sala_actual | jugador2: nombre_jugador }

    end

    Agent.update(__MODULE__, fn todas -> Map.put(todas, sala_nombre, nueva_info) end)

  end

  def agregar_respuestas(sala_nombre, respuestas) do
    #[{"jugador1", "jugador1"}, {"jugador2", "jugador1"}]
    todas = traer_todas
    sala_actual = Map.get(todas, sala_nombre)

    nuevas_respuestas = sala_actual[:respuestas] ++ respuestas
    nueva_info = %{ sala_actual | respuestas: nuevas_respuestas }
    Agent.update(__MODULE__, fn todas -> Map.put(todas, sala_nombre, nueva_info) end)
  end

  def traer_todas do
    Agent.get(__MODULE__, fn todas -> todas end)
  end

end
