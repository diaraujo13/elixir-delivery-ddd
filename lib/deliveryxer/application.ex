defmodule Deliveryxer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Deliveryxer.Repo,
      # Start the Telemetry supervisor
      DeliveryxerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Deliveryxer.PubSub},
      # Start the Endpoint (http/https)
      DeliveryxerWeb.Endpoint
      # Start a worker by calling: Deliveryxer.Worker.start_link(arg)
      # {Deliveryxer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Deliveryxer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @spec config_change(any, any, any) :: :ok
  def config_change(changed, _new, removed) do
    DeliveryxerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
