defmodule LaGuerraDeLosLados.PageController do
  use LaGuerraDeLosLados.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
