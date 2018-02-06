# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :user_id
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.text :description, null: false, default: ''
      t.timestamps
    end
  end
end
