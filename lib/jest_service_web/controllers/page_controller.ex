defmodule JestServiceWeb.PageController do
  use JestServiceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
