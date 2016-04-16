defmodule LaGuerraDeLosLados.JuegoChannel do
	use Phoenix.Channel
	alias Phoenix.Socket

	def join("juego:" <> salaNombre, msj, socket) do
		IO.puts "Nuevo juego #{inspect salaNombre}"
		{:ok, socket}
	end

end
