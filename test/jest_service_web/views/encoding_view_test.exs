defmodule JestServiceWeb.EncodingViewTest do
  use JestServiceWeb.ConnCase, async: true
  import JestServiceApiWeb.EncodingView

  test "returns message and status for successful encoding" do
    params = %{encoded_response: {:ok, "encoded_message"}}
    expected = %{status: 200, message: "encoded_message"}
    assert render("encoding.json", params) == expected
  end

  test "returns error and status for failed encoding" do
    params = %{encoded_response: {:error, "error_message"}}
    expected = %{status: 400, error_message: "error_message"}
    assert render("encoding.json", params) == expected
  end

  test "returns error and status for unknown error for encoding" do
    params = %{encoded_response: {:other, "error_message"}}
    expected = %{status: 500, error_message: "An unknown error has occurred"}
    assert render("encoding.json", params) == expected
  end

  test "returns message and status for successful decoding" do
    params = %{decoded_response: {:ok, %{author: "Joe King"}}}
    expected = %{status: 200, jest_description: %{author: "Joe King"}}
    assert render("decoding.json", params) == expected
  end

  test "returns error and status for failed decoding" do
    params = %{decoded_response: {:error, "Whoops"}}
    expected = %{status: 400, error_message: "Whoops"}
    assert render("decoding.json", params) == expected
  end

  test "returns error and status for unknown error for decoding" do
    params = %{decoded_response: {:other, "error_message"}}
    expected = %{status: 500, error_message: "An unknown error has occurred"}
    assert render("decoding.json", params) == expected
  end
end
