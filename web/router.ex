defmodule LaGuerraDeLosLados.Router do
  use LaGuerraDeLosLados.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LaGuerraDeLosLados do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

	scope "/api", LaGuerraDeLosLados do
		pipe_through :api
		resources "/salas", SalasController
  end
end
