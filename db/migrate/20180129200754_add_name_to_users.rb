class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
      add_column :users, :name,  :string
      add_column :users, :phone, :string
  end
end
