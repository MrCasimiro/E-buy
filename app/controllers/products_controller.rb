class ProductsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			flash.now[:success] = "Produto adicionado com sucesso"
		end
		render 'index'
	end

	def edit
		tmp = Product.find(params[:id])
		unless tmp.user_id == current_user.id
			raise ActionController::RoutingError.new('Not Found')
		else
			@product = tmp
		end
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(product_params)
			redirect_to	root_path
		else
			render 'edit'
		end
	end

	def show
	end

	def destroy
	end

	private

	def product_params
		params.require(:product).permit(:name, :user_id , :price, :description, {photos: []})
	end
end
