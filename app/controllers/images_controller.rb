class ImagesController < ApplicationController
	before_action :authenticate_user!

	def new
		@images = Image.where(product_id: params[:product_id])
		@new_image = Image.new
	end

	def create
		@images = Image.where(product_id: params[:product_id])
		@new_image = Image.new(product_id: params[:product_id])
		@image = Image.new(image_params)
		if @image.save
			flash.now[:success] = "Image adicionada com sucesso"
		end
		render 'new'
	end

	def destroy
		image = Image.find(params[:id])
		image.destroy!
		redirect_to root_path
	end

	private

	def image_params
		params.require(:image).permit(:product_id, :photo)
	end
end