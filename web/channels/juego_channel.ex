defmodule LaGuerraDeLosLados.JuegoChannel do
  use Phoenix.Channel
  alias Phoenix.Socket

  #TODO: Hacer un chequeo de verdad de la cantidad de jugadores.
  #TODO: Implementar proceso aparte para mantener el estado.
  #TODO: La variable en params salaNombre, sobra.
  def join("juego:" <> salaNombre, params, socket) do
    jugador_sala = params["salaNombre"]
    jugador_nombre = params["jugadorNombre"]
    jugador_numero = params["jugadorNumero"]

    case jugador_numero do
      "jugador2"  ->  IO.puts "Sala #{inspect salaNombre} lista"
      _           ->  true
    end
    {:ok, socket
          |> Socket.assign(:jugador_sala, jugador_sala)
          |> Socket.assign(:jugador_nombre, jugador_nombre)
          |> Socket.assign(:jugador_numero, jugador_sala)
    }
  end

end
