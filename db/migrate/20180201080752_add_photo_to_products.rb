class AddPhotoToProducts < ActiveRecord::Migration[5.1]
  def change
		add_column :products, :photos, :string
	end
end
