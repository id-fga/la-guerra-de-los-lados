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
              respuestas: [],
              mazo_jugador1: [],
              mazo_jugador2: []
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
    todas = traer_todas
    sala_actual = Map.get(todas, sala_nombre)

    nuevas_respuestas = sala_actual[:respuestas] ++ respuestas
    nueva_info = %{ sala_actual | respuestas: nuevas_respuestas }
    Agent.update(__MODULE__, fn todas -> Map.put(todas, sala_nombre, nueva_info) end)
  end

  def agregar_mazo(sala_nombre, numero_jugador, mazo) do
    todas = traer_todas
    sala_actual = Map.get(todas, sala_nombre)

    mazo = case numero_jugador do
      "jugador1"  ->  nueva_info = %{ sala_actual | mazo_jugador1: mazo }
      "jugador2"  ->  nueva_info = %{ sala_actual | mazo_jugador2: mazo }
    end

    Agent.update(__MODULE__, fn todas -> Map.put(todas, sala_nombre, nueva_info) end)
  end 

  def traer_carta(sala_nombre, numero_jugador, idx) do
    todas = traer_todas
    sala_actual = Map.get(todas, sala_nombre)

    mazo = case numero_jugador do
      "jugador1"  -> sala_actual[:mazo_jugador1]
      "jugador2"  -> sala_actual[:mazo_jugador2]
    end

    Enum.at(mazo, idx)
  end

  def traer_todas do
    Agent.get(__MODULE__, fn todas -> todas end)
  end

end
