defmodule Hola.RoomChannel do
    use Phoenix.Channel
    alias Hola.Agente

    def join("rooms:" <> sala, [jugador_nro, jugador], socket) do

        case jugador_nro do
            "jugador1"  ->  IO.puts "#{jugador} crea la sala #{sala}"
                            Agente.agregar_sala(String.to_atom(sala))
                            Agente.agregar_jugador(String.to_atom(sala), {:jugador1, jugador})

            "jugador2"  ->  IO.puts "#{jugador} se une a la sala #{sala}"
                            Agente.agregar_jugador(String.to_atom(sala), {:jugador2, jugador})
        end

        send(self, :after_join)
        {:ok, assign(socket, :sala_nombre, sala)}
    end

    def handle_info(:after_join, socket) do

        sala_nombre = socket.assigns[:sala_nombre]
        todos = Agente.traer_todos
        sala = todos[String.to_atom(sala_nombre)]

        cond do
            sala.cant_jugadores > 2 ->
                IO.puts "La sala #{sala_nombre} esta llena"
                broadcast! socket, "sala_llena", %{}

            sala.cant_jugadores == 2 ->
                broadcast! socket, "sala_completa", %{jugador1: sala.jugador1, jugador2: sala.jugador2}

            true ->
                IO.puts "Hay espacio en la sala: #{sala_nombre}"
        end

        {:noreply, socket}
    end

    def handle_in("new_msg", %{"body" => body}, socket) do
        broadcast! socket, "new_msg", %{body: body}
        {:noreply, socket}
    end

    def terminate(reason, socket) do
        sala_nombre = socket.assigns[:sala_nombre]
        IO.puts "Salio un integrante de #{sala_nombre}"
        :ok
    end


    #def handle_out("new_msg", payload, socket) do
    #    push socket, "new_msg", payload
    #    {:noreply, socket}
    #end

end
