class Flight < ApplicationRecord
  has_many :orders
  validates :priceBus, presence:  true, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :priceStan, presence:  true, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :pricePriv, presence:  true, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :priceLag, presence:  true, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :destination, presence:  true
  validates :date, presence:  true
  validates :time, presence:  true
  validates :placesStan, presence:  true ,numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :placesStan, presence:  true, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
end
