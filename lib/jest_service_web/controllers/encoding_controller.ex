defmodule JestServiceApiWeb.EncodingController do
  use JestServiceWeb, :controller

  def encode(conn, params) do
    body = Map.get(params, "body")
    punchline = Map.get(params, "punchline")
    author = Map.get(params, "author")

    encoded_response = JestParser.encode(%{body: body, punchline: punchline, author: author})
    do_encode(conn, encoded_response, body, punchline, author)
  end

  def decode(conn, %{"message" => message}) do
    decoded_response = JestParser.decode(message)
    do_decode(conn, decoded_response)
  end

  defp do_encode(conn, {:ok, _message} = encoded_response, body, punchline, author) do
    insert_joke(body, punchline, author, false)
    render(conn, "encoding.json", encoded_response: encoded_response)
  end
  defp do_encode(conn, encoded_response, _body, _punchline, _author) do
    conn
    |> put_status(400)
    |> render("encoding.json", encoded_response: encoded_response)
  end

  defp do_decode(conn, {:ok, jest_params} = decoded_response) do
    insert_decoded_response(jest_params)
    render(conn, "decoding.json", decoded_response: decoded_response)
  end
  defp do_decode(conn, decoded_response) do
    conn
    |> put_status(400)
    |> render("decoding.json", decoded_response: decoded_response)
  end

  defp insert_joke(body, punchline, author, encoded?) do
    joke = %JestService.Joke{body: body,
      punchline: punchline,
      author: author,
      encoded: encoded?}
    JestService.Repo.insert(joke)
  end

  defp insert_decoded_response(%{body: body, punchline: punchline, author: author}) do
    insert_joke(body, punchline, author, false)
  end
end
