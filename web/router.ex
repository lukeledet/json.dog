defmodule Dog.Router do
  use Dog.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Dog do
    pipe_through :api
  end
end
