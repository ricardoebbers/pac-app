defmodule Pac.Repo do
  use Ecto.Repo,
    otp_app: :pac,
    adapter: Ecto.Adapters.Postgres
end
