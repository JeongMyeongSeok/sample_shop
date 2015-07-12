class ProductsController < ApplicationController
  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_url
    else
      @add_product_into_cart = current_user.cart_details.build(product_id: @product.id)
      @product
    end
  end
end
