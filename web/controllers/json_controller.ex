defmodule Dog.JSONController do
  use Dog.Web, :controller

  plug :advertise

  def index(conn, _) do
    response = %{
      ip: remote_ip(conn),
      request_headers: request_headers(conn),
      about: %{
        created_by: "@lukeledet",
        repo: "https://github.com/lukeledet/json.dog",
        description: """
        json.dog was created for debugging all kinds of web requests. It's a
        free service that will remain free for.e.ver. If you think it's missing
        any data, open an issue on the repo or, better yet, a pull request.
        """
      }
    }

    json conn, response
  end

  # This supports deployment to services behind a proxy like dokku or heroku
  defp remote_ip(conn) do
    conn.req_headers
    |> Enum.filter(&match?({"x-forwarded-for", _}, &1))
    |> case do
      [{"x-forwarded-for", ip}] ->
        ip
      _ ->
        conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    end
  end

  defp request_headers(%{method: "GET"} = conn) do
    Enum.into(conn.req_headers, %{})
  end

  defp request_headers(%{method: "POST"} = conn) do
    Enum.into(conn.req_headers, %{
      body: conn.private[:raw_body]
    })
  end

  defp advertise(conn, _) do
    put_resp_header(conn, "X-REVELRY", "If you're reading this, apply to work at Revelry! http://bit.ly/1Sxs75N")
  end
end
