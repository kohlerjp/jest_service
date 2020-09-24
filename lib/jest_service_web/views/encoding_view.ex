defmodule JestServiceApiWeb.EncodingView do
  use JestServiceWeb, :view

  # Encoding
  def render("encoding.json", %{encoded_response: {:ok, message}}) do
    %{status: 200, message: message}
  end
  def render("encoding.json", %{encoded_response: {:error, message}}) do
    %{status: 400, error_message: message}
  end
  def render("encoding.json", _unknown) do
    %{status: 500, error_message: "An unknown error has occurred"}
  end

  # Decoding
  def render("decoding.json", %{decoded_response: {:ok, jest_map}}) do
    %{status: 200, jest_description: jest_map}
  end
  def render("decoding.json", %{decoded_response: {:error, message}}) do
    %{status: 400, error_message: message}
  end
  def render("decoding.json", _unknown) do
    %{status: 500, error_message: "An unknown error has occurred"}
  end
end
