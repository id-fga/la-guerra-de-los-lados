defmodule LaGuerraDeLosLados.JuegoChannel do
  use Phoenix.Channel
  alias Phoenix.Socket
  alias LaGuerraDeLosLados.Mano
  alias LaGuerraDeLosLados.Respuestas

  #TODO: Hacer un chequeo de verdad de la cantidad de jugadores.
  #TODO: Implementar proceso aparte para mantener el estado.
  #TODO: Arreglar pedido de assigns, es repetir mucho codigo sin necesidad
  #TODO: Separar funciones para manejo de mazo
  #TODO: Poner constantes prolijas, ej: cantidad de manos
  def mezclar({:ok, json}) do
    Map.get(json, "mazo")
    |> Enum.shuffle
  end

  def traer_carta(mazo, idx) do
    Enum.at(mazo, idx)
  end

  #def enviar_mano(idx, socket) when idx < 24 do
  def enviar_mano(idx, socket) when idx < 2 do
    mazo = socket.assigns.mazo
    broadcast!(socket, "proxima_mano", %{ mano_numero: idx,
                                          carta: traer_carta(mazo, idx)})
  end

  #TODO: Chequear este encode y decode
  def enviar_mano(idx, socket) do
    IO.puts "FIN DEL JUEGO"
    jugador_sala = socket.assigns.jugador_sala
    {:ok, respuestas} =  Respuestas.traer_sala(jugador_sala)
                |> JSON.encode!
                |> JSON.decode


    broadcast!(socket, "fin_juego", %{ respuestas: respuestas })
  end


  def join("juego:" <> salaNombre, params, socket) do
    jugador_sala = params["salaNombre"]
    jugador_nombre = params["jugadorNombre"]
    jugador_numero = params["jugadorNumero"]

    #TODO: Emprolijar esto
    mazo  = File.read!("priv/data/mazo.json")
          |> JSON.decode
          |> mezclar

    :timer.send_interval(3000, :send_ping)
    send(self, :after_join)

    {:ok, socket
          |> Socket.assign(:jugador_sala, jugador_sala)
          |> Socket.assign(:jugador_nombre, jugador_nombre)
          |> Socket.assign(:jugador_numero, jugador_numero)
          |> Socket.assign(:mano_numero, 1)
          |> Socket.assign(:mazo, mazo)
    }
  end

  def handle_info(:after_join, socket) do
    jugador_numero = socket.assigns.jugador_numero
    jugador_sala = socket.assigns.jugador_sala

    case jugador_numero do
      "jugador2"  ->  
                      IO.puts "Sala #{inspect jugador_sala} lista"
                      Mano.agregar_sala(jugador_sala)
                      Respuestas.agregar_sala(jugador_sala)
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

    #IO.puts "#{jugador_nombre} (#{jugador_numero}) de la #{jugador_sala} responde"

    {:noreply, socket}
  end

  def handle_in("jugar", op, socket) do
    jugador_nombre = socket.assigns.jugador_nombre
    jugador_sala = socket.assigns.jugador_sala
    jugador_numero = socket.assigns.jugador_numero
    mano_numero = socket.assigns.mano_numero

    IO.puts "Mano: #{mano_numero} Juega #{inspect jugador_nombre} y elige #{inspect op}"

    Mano.agregar_respuesta(jugador_sala, jugador_numero, op)

    case Mano.traer_sala(jugador_sala) |> length do
      2 ->  Respuestas.agregar_respuestas(jugador_sala, Mano.traer_sala(jugador_sala))
            Mano.vaciar_respuestas(jugador_sala)

            Respuestas.traer_sala(jugador_sala)
            |> length
            |> enviar_mano(socket)
            

      _ ->  :ok

    end

    {:noreply, socket}
  end

end
