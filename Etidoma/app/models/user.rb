class User < ActiveRecord::Base
  validates :nombre, presence: true
  validates :razonSocial, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, presence: true
  validates :telefono, presence: true
  validates :cotizacion, presence: true
end
