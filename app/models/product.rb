# frozen_string_literal: true

# One product has an owner (user) and if a product is destroyed
# all of your photos attached via images also has to be destroyed.
class Product < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :description, :images, presence: true
  validates :price, presence: true, numericality: { greater_than: 0,
                                                    less_than: 1_000_000 }

  self.per_page = 3

  def self.search(term, client)
    if term
      if client.nil?
        where('name LIKE ?', "%#{term}%")
      else
        where('name LIKE ? AND user_id != ?', "%#{term}%",
              client.id).order('id DESC')
      end
    else
      client.nil? ? order('id DESC') : where.not(user_id: client.id)
    end
  end
end
