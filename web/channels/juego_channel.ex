defmodule LaGuerraDeLosLados.JuegoChannel do
  use Phoenix.Channel
  alias Phoenix.Socket

  #TODO: Hacer un chequeo de verdad de la cantidad de jugadores.
  #TODO: Implementar proceso aparte para mantener el estado.
  def join("juego:" <> salaNombre, params, socket) do
    jugador_sala = params["salaNombre"]
    jugador_nombre = params["jugadorNombre"]
    jugador_numero = params["jugadorNumero"]

    :timer.send_interval(3000, :send_ping)
    send(self, :after_join)

    {:ok, socket
          |> Socket.assign(:jugador_sala, jugador_sala)
          |> Socket.assign(:jugador_nombre, jugador_nombre)
          |> Socket.assign(:jugador_numero, jugador_numero)
    }
  end

  def handle_info(:after_join, socket) do
    jugador_numero = socket.assigns.jugador_numero
    jugador_sala = socket.assigns.jugador_sala

    case jugador_numero do
      "jugador2"  ->  
                      IO.puts "Sala #{inspect jugador_sala} lista"
                      broadcast!(socket, "empezar_juego", %{})
      _           ->  true
    end

    {:noreply, socket}
  end

  def handle_info(:send_ping, socket) do
    push(socket, "ping", %{})
    {:noreply, socket}
  end

  def handle_in("pong", op, socket) do
    jugador_nombre = socket.assigns.jugador_nombre
    jugador_sala = socket.assigns.jugador_sala
    jugador_numero = socket.assigns.jugador_numero

    IO.puts "#{jugador_nombre} (#{jugador_numero}) de la #{jugador_sala} responde"

    {:noreply, socket}
  end

  def handle_in("jugar", op, socket) do
    jugador_nombre = socket.assigns.jugador_nombre

    IO.puts "Juega #{inspect jugador_nombre} y elige #{inspect op}"
    broadcast!(socket, "proxima_mano", %{})
    {:noreply, socket}
  end


end
