class CreatePhoto < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
			t.integer :product_id
			t.string :photos
			t.timestamps
    end
  end
end
