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
        {:ok, socket}
    end

    def handle_info(:after_join, socket) do
        jugadores = Agente.traer_todos
        IO.puts "#{inspect jugadores}"
        #IO.puts length(jugadores)

        #case length(jugadores) do
        #    2   ->  IO.puts "Sala lista"
        #            broadcast! socket, "lista_jugadores", %{resp: jugadores}
        #    _   -> :ok
        #end

        broadcast! socket, "lista_jugadores", %{}
        {:noreply, socket}
    end

    def handle_in("new_msg", %{"body" => body}, socket) do
        broadcast! socket, "new_msg", %{body: body}
        {:noreply, socket}
    end

    def terminate(reason, _socket) do
        IO.puts "> leave #{inspect reason}"
        :ok
    end


    #def handle_out("new_msg", payload, socket) do
    #    push socket, "new_msg", payload
    #    {:noreply, socket}
    #end

end
