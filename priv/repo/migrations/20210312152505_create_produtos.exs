defmodule Deliveryxer.Repo.Migrations.CreateProdutos do
  use Ecto.Migration

  def change do
    create table(:produtos) do
      add :name, :string
      add :descr, :string
      add :qty, :integer
      add :price, :float

      timestamps()
    end

  end
end
