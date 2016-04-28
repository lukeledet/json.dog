defmodule Dog.Endpoint do
  use Phoenix.Endpoint, otp_app: :json_dog

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug :copy_req_body
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_json_dog_key",
    signing_salt: "GP4Mhe4N"

  plug Dog.Router

  defp copy_req_body(conn, _) do
    copy_body({:more, "", conn})
  end

  defp copy_body(read_body_response, result \\ "")

  defp copy_body({:ok, body, conn}, result) do
    Plug.Conn.put_private(conn, :raw_body, result <> body)
  end

  defp copy_body({:more, body, conn}, result) do
    conn
    |> Plug.Conn.read_body
    |> copy_body(result <> body)
  end
end
