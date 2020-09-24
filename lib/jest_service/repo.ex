defmodule JestService.Repo do
  use Ecto.Repo,
    otp_app: :jest_service,
    adapter: Ecto.Adapters.Postgres
end
