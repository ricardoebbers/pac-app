defmodule Pac.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PacWeb.Telemetry,
      # Start the Ecto repository
      Pac.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pac.PubSub},
      # Start Finch
      {Finch, name: Pac.Finch},
      # Start the Endpoint (http/https)
      PacWeb.Endpoint
      # Start a worker by calling: Pac.Worker.start_link(arg)
      # {Pac.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pac.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PacWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
