defmodule Deliveryxer.Order.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "produtos" do
    field :descr, :string
    field :name, :string
    field :price, :float
    field :qty, :integer

    timestamps()
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:name, :descr, :qty, :price])
    |> validate_required([:name, :descr, :qty, :price])
  end
end
