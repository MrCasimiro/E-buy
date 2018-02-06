class ProductsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@products = Product.search(params[:term], 
			current_user).paginate(:page => params[:page])
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			flash.now[:success] = "Produto adicionado com sucesso"
		end
		@products = Product.search(nil, current_user).paginate(:page => params[:page])
		render 'index'
	end

	def edit
		tmp = Product.find(params[:id])
		unless tmp.user_id == current_user.id
			raise ActionController::RoutingError.new('Not Found')
		else
			@product = tmp
			@images = @product.images
		end
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(product_params)
			@products = Product.search(nil, current_user).paginate(:page => params[:page])
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
			:page => params[:page]).order('id ASC')
	end

	private

	def product_params
		params.require(:product).permit(:name, :user_id , :price, :description, :term, 
			:images_attributes => [:photo, :product_id])
	end
end
