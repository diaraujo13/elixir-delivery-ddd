defmodule DeliveryxerWeb.ProdutoController do
  use DeliveryxerWeb, :controller

  alias Deliveryxer.Order
  alias Deliveryxer.Order.Produto

  action_fallback DeliveryxerWeb.FallbackController

  def index(conn, _params) do
    produtos = Order.list_produtos()
    render(conn, "index.json", produtos: produtos)
  end

  def create(conn, %{"produto" => produto_params}) do
    with {:ok, %Produto{} = produto} <- Order.create_produto(produto_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.produto_path(conn, :show, produto))
      |> render("show.json", produto: produto)
    end
  end

  def show(conn, %{"id" => id}) do
    produto = Order.get_produto!(id)
    render(conn, "show.json", produto: produto)
  end

  def update(conn, %{"id" => id, "produto" => produto_params}) do
    produto = Order.get_produto!(id)

    with {:ok, %Produto{} = produto} <- Order.update_produto(produto, produto_params) do
      render(conn, "show.json", produto: produto)
    end
  end

  def delete(conn, %{"id" => id}) do
    produto = Order.get_produto!(id)

    with {:ok, %Produto{}} <- Order.delete_produto(produto) do
      send_resp(conn, :no_content, "")
    end
  end
end
