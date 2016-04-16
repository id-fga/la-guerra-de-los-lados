defmodule LaGuerraDeLosLados.JuegoChannel do
	use Phoenix.Channel
	alias Phoenix.Socket

	def join("juego:" <> salaNombre, params, socket) do
		IO.puts "Nuevo juego #{inspect params}"
		{:ok, socket}
	end

end
