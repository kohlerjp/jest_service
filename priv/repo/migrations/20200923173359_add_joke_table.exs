defmodule JestService.Repo.Migrations.AddJokeTable do
  use Ecto.Migration

  def change do
    create table("joke") do
      add :body,       :string, size: 300
      add :author,     :string, size: 300
      add :punchline,  :string, size: 300
      add :encoded,    :boolean

      timestamps()
    end

  end
end
