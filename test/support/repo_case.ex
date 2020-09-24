defmodule JestService.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias JestService.Repo

      import Ecto
      import Ecto.Query
      import JestService.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(JestService.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(JestService.Repo, {:shared, self()})
    end

    :ok
  end
end
