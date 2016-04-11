defmodule Hola.PageController do
  use Hola.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
