class ProductsController < ApplicationController

  # サイドバー表示用
  before_action :set_genres

  def show
    @product = Product.find(params[:id])
    @cart = @product.cart_items.build #モデルなのでbuildを使用
  end

  def index
    # ジャンルが有効 かつ 商品ステータスが有効 な商品を数える
    @products = Product.includes(:genre).where(genres: {validity: true}).is_active.page(params[:page]).per(9)
  end

  private

  def set_genres
    @genre = Genre.is_valid
  end

  def product_params
    params.require(:product).permit(:name,:price,:image_id, :genre_id)
  end
end
