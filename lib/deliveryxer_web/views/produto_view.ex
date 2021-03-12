defmodule DeliveryxerWeb.ProdutoView do
  use DeliveryxerWeb, :view
  alias DeliveryxerWeb.ProdutoView

  def render("index.json", %{produtos: produtos}) do
    %{data: render_many(produtos, ProdutoView, "produto.json")}
  end

  def render("show.json", %{produto: produto}) do
    %{data: render_one(produto, ProdutoView, "produto.json")}
  end

  def render("produto.json", %{produto: produto}) do
    %{id: produto.id,
      name: produto.name,
      descr: produto.descr,
      qty: produto.qty,
      price: produto.price}
  end
end
