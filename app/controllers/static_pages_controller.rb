class StaticPagesController < ApplicationController
  def home
    @products = Product.paginate(page: params[:page], :per_page => 7)
  end

  def help
  end

  def about
  end

  def contact
  end
end
