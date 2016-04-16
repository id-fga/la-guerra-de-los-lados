defmodule LaGuerraDeLosLados.SalasController do
	use LaGuerraDeLosLados.Web, :controller

	alias LaGuerraDeLosLados.Salas

	def index(conn, _params) do
		render(conn, "index.json", salas: [1, 2, 3])
	end

end
