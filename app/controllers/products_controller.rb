class ProductsController < ApplicationController
  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_url
    else
      @product
    end
  end
end
