defmodule JestServiceApiWeb.EncodingControllerTest do
  use JestServiceWeb.ConnCase

  test "POST /api/encode success", %{conn: conn} do
    post_params = %{
      body: "What do you call cheese that isn't yours?",
      punchline: "Nacho Cheese",
      author: "Anita Bath"
    }
    expected_response = %{
      "message" => "What do you call cheese that isn't yours?|4E6163686F20436865657365|Anita Bath",
      "status" => 200
    }
    conn = post(conn, "/api/encode", post_params)
    assert json_response(conn, 200) == expected_response
  end

  test "POST /api/encode failure", %{conn: conn} do
    post_params = %{
      body: "What do you call cheese that isn't yours?",
      punchline: 123,
      author: "Anita Bath"
    }
    expected_response = %{
      "error_message" => "Punchline can not be encoded",
      "status" => 400
    }
    conn = post(conn, "/api/encode", post_params)
    assert json_response(conn, 400) == expected_response
  end

  test "POST /api/decode success", %{conn: conn} do
    post_params = %{message: "What do you call cheese that isn't yours?|4E6163686F20436865657365|Anita Bath"}
    expected_response = %{
      "status" => 200,
      "jest_description" => %{
        "author" => "Anita Bath",
        "body" => "What do you call cheese that isn't yours?",
        "punchline" => "Nacho Cheese"
      }
    }
    conn = post(conn, "/api/decode", post_params)
    assert json_response(conn, 200) == expected_response
  end

  test "POST /api/decode failure", %{conn: conn} do
    post_params = %{message: "What do you call cheese that isn't yours?"}
    expected_response = %{
      "status" => 400,
      "error_message" => "Message is not formatted correctly"
    }
    conn = post(conn, "/api/decode", post_params)
    assert json_response(conn, 400) == expected_response
  end

  # Testing insertion into database
  test "Database is updated on successful encoding", %{conn: conn} do
    post_params = %{
      body: "What do you call cheese that isn't yours",
      punchline: "Nacho Cheese",
      author: "Anita Bath"
    }
    post(conn, "/api/encode", post_params)
    joke = JestService.Joke
            |> JestService.Repo.all()
            |> List.first
    assert joke.body == post_params.body
    assert joke.punchline == post_params.punchline
    assert joke.author == post_params.author
  end

  test "Database is not updated on failed encoding", %{conn: conn} do
    post_params = %{
      body: "What do you call cheese that isn't yours?",
      punchline: 123,
      author: "Anita Bath"
    }
    post(conn, "/api/encode", post_params)
    jokes = JestService.Repo.all(JestService.Joke)
    assert Enum.empty?(jokes)
  end

  test "Database is updated on successful decoding", %{conn: conn} do
    encoded = "5468657927726520616C7761797320757020746F20736F6D657468696E6721"
    post_params = %{message: "I don't trust stairs|#{encoded}|Joe King"}
    post(conn, "/api/decode", post_params)

    joke = JestService.Joke
            |> JestService.Repo.all()
            |> List.first
    assert joke.body == "I don't trust stairs"
    assert joke.punchline == "They're always up to something!"
    assert joke.author == "Joe King"
  end

  test "Database is not updated on failed decoding", %{conn: conn} do
    post_params = %{message: "I don't trust stairs"}
    post(conn, "/api/decode", post_params)

    jokes = JestService.Repo.all(JestService.Joke)
    assert Enum.empty?(jokes)
  end
end
