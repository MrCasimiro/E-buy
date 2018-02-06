# frozen_string_literal: true

# ProductsController handles over about listing, creation,
# update, remove products, also show a specific product and
# list the products a user wants to sell
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @products = Product.search(params[:term],
                               current_user).paginate(page: params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    flash.now[:success] = 'Produto adicionado com sucesso' if @product.save
    @products = Product.search(nil,
                               current_user).paginate(page: params[:page])
    render 'index'
  end

  def edit
    tmp = Product.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if tmp.user_id != current_user.id
    @product = tmp
    @images = @product.images
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      @products = Product.search(nil,
                                 current_user).paginate(page: params[:page])
      redirect_to	root_path
    else
      render 'edit'
    end
  end

  def show
    @product = Product.find(params[:id])
    @salesman = User.find(@product.user_id)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy!
    redirect_to root_path
  end

  def my_products
    @products = Product.where(user_id: current_user.id).paginate(
      page: params[:page]
    ).order('id ASC')
  end

  private

  def product_params
    params.require(:product).permit(:name, :user_id, :price, :description,
                                    :term,
                                    images_attributes: %i[photo product_id])
  end
end
