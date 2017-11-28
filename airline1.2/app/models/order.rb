class Order < ApplicationRecord
  belongs_to :flight
  validates :name, presence:  true
  validates :passport, presence:  true
  validates :surname, presence:  true
end
