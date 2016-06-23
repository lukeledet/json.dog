defmodule Dog.Router do
  use Dog.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dog do
    pipe_through :api

    get "/", JSONController, :index
    post "/", JSONController, :index
  end
end
