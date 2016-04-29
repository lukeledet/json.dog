defmodule Dog.JSONController do
  use Dog.Web, :controller

  def index(conn, _) do
    response = %{
      endpoints: %{
        get: [
          "/about",
          "/ip",
          "/request_headers"
        ],
        post: [
          "/request_headers"
        ]
      }
    }

    json conn, response
  end

  def about(conn, _) do
    response = %{
      created_by: "@lukeledet",
      repo: "https://github.com/lukeledet/json.dog",
      description: """
      json.dog was created for debugging all kinds of web requests. It's a
      free service that will remain free for.e.ver. If you think it's missing
      any data, open an issue on the repo or, better yet, a pull request.
      """
    }

    json conn, response
  end

  def ip(conn, _) do
    response = %{
      ip: conn.remote_ip |> Tuple.to_list |> Enum.join(".")
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
      nil ->
        conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    end
  end

  def request_headers(%{method: "GET"} = conn, _) do
    response = Enum.into(conn.req_headers, %{})

    json conn, response
  end

  def request_headers(%{method: "POST"} = conn, _) do
    response = Enum.into(conn.req_headers, %{
      body: conn.private[:raw_body]
    })

    json conn, response
  end
end
