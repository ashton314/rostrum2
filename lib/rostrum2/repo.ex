defmodule Rostrum.Repo do
  use Ecto.Repo,
    otp_app: :rostrum2,
    adapter: Ecto.Adapters.Postgres
end
