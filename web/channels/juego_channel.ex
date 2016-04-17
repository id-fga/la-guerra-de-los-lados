defmodule LaGuerraDeLosLados.JuegoChannel do
  use Phoenix.Channel

  #TODO: Hacer un chequeo de verdad de la cantidad de jugadores
  #TODO: Implementar proceso aparte para mantener el estado
  def join("juego:" <> salaNombre, params, socket) do
    case params["jugadorNumero"] do
      "jugador2"  ->  IO.puts "Sala #{inspect salaNombre} lista"
      _           ->  true
    end
    {:ok, socket}
  end

end
