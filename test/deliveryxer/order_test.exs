defmodule Deliveryxer.OrderTest do
  use Deliveryxer.DataCase

  alias Deliveryxer.Order

  describe "produtos" do
    alias Deliveryxer.Order.Produto

    @valid_attrs %{descr: "some descr", name: "some name", price: 120.5, qty: 42}
    @update_attrs %{descr: "some updated descr", name: "some updated name", price: 456.7, qty: 43}
    @invalid_attrs %{descr: nil, name: nil, price: nil, qty: nil}

    def produto_fixture(attrs \\ %{}) do
      {:ok, produto} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Order.create_produto()

      produto
    end

    test "list_produtos/0 returns all produtos" do
      produto = produto_fixture()
      assert Order.list_produtos() == [produto]
    end

    test "get_produto!/1 returns the produto with given id" do
      produto = produto_fixture()
      assert Order.get_produto!(produto.id) == produto
    end

    test "create_produto/1 with valid data creates a produto" do
      assert {:ok, %Produto{} = produto} = Order.create_produto(@valid_attrs)
      assert produto.descr == "some descr"
      assert produto.name == "some name"
      assert produto.price == 120.5
      assert produto.qty == 42
    end

    test "create_produto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Order.create_produto(@invalid_attrs)
    end

    test "update_produto/2 with valid data updates the produto" do
      produto = produto_fixture()
      assert {:ok, %Produto{} = produto} = Order.update_produto(produto, @update_attrs)
      assert produto.descr == "some updated descr"
      assert produto.name == "some updated name"
      assert produto.price == 456.7
      assert produto.qty == 43
    end

    test "update_produto/2 with invalid data returns error changeset" do
      produto = produto_fixture()
      assert {:error, %Ecto.Changeset{}} = Order.update_produto(produto, @invalid_attrs)
      assert produto == Order.get_produto!(produto.id)
    end

    test "delete_produto/1 deletes the produto" do
      produto = produto_fixture()
      assert {:ok, %Produto{}} = Order.delete_produto(produto)
      assert_raise Ecto.NoResultsError, fn -> Order.get_produto!(produto.id) end
    end

    test "change_produto/1 returns a produto changeset" do
      produto = produto_fixture()
      assert %Ecto.Changeset{} = Order.change_produto(produto)
    end
  end
end
