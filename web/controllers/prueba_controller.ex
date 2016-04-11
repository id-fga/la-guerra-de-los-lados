defmodule Hola.PruebaController do
  use Hola.Web, :controller

  def prueba(conn, %{"param" => param}) do
    render conn, "prueba.html", param: param
  end
end
