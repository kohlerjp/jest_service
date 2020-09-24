defmodule JestService.Joke do
  use Ecto.Schema

  schema "joke" do
    field :body, :string
    field :punchline, :string
    field :author, :string
    field :encoded, :boolean
    timestamps()
  end
end
