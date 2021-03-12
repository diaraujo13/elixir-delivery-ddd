defmodule DeliveryxerWeb.ProdutoControllerTest do
  use DeliveryxerWeb.ConnCase

  alias Deliveryxer.Order
  alias Deliveryxer.Order.Produto

  @create_attrs %{
    descr: "some descr",
    name: "some name",
    price: 120.5,
    qty: 42
  }
  @update_attrs %{
    descr: "some updated descr",
    name: "some updated name",
    price: 456.7,
    qty: 43
  }
  @invalid_attrs %{descr: nil, name: nil, price: nil, qty: nil}

  def fixture(:produto) do
    {:ok, produto} = Order.create_produto(@create_attrs)
    produto
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all produtos", %{conn: conn} do
      conn = get(conn, Routes.produto_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create produto" do
    test "renders produto when data is valid", %{conn: conn} do
      conn = post(conn, Routes.produto_path(conn, :create), produto: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.produto_path(conn, :show, id))

      assert %{
               "id" => id,
               "descr" => "some descr",
               "name" => "some name",
               "price" => 120.5,
               "qty" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.produto_path(conn, :create), produto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update produto" do
    setup [:create_produto]

    test "renders produto when data is valid", %{conn: conn, produto: %Produto{id: id} = produto} do
      conn = put(conn, Routes.produto_path(conn, :update, produto), produto: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.produto_path(conn, :show, id))

      assert %{
               "id" => id,
               "descr" => "some updated descr",
               "name" => "some updated name",
               "price" => 456.7,
               "qty" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, produto: produto} do
      conn = put(conn, Routes.produto_path(conn, :update, produto), produto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete produto" do
    setup [:create_produto]

    test "deletes chosen produto", %{conn: conn, produto: produto} do
      conn = delete(conn, Routes.produto_path(conn, :delete, produto))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.produto_path(conn, :show, produto))
      end
    end
  end

  defp create_produto(_) do
    produto = fixture(:produto)
    %{produto: produto}
  end
end
