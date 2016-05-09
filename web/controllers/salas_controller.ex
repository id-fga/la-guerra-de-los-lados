defmodule LaGuerraDeLosLados.SalasController do
	use LaGuerraDeLosLados.Web, :controller

	alias LaGuerraDeLosLados.Salas
  alias LaGuerraDeLosLados.Respuestas

	def index(conn, _params) do
    #render(conn, "index.json", salas: [1, 2, 3])
    data = Respuestas.traer_salas_disponibles
    json conn, data
	end

end
