defmodule Dog.Router do
  use Dog.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dog do
    pipe_through :api

    get "/", JSONController, :index
    get "/ip", JSONController, :ip
    get "/request_headers", JSONController, :request_headers
    post "/request_headers", JSONController, :request_headers
    get "/about", JSONController, :about
  end
end
