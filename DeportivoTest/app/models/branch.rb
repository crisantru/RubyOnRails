class Branch < ActiveRecord::Base
	has_many :bills
	has_many :inventories
	belongs_to :stock

	validates_presence_of :name, :message => '^Ingresar nombre del proveedor'
	validates_presence_of :address, :message => '^Ingresar dirección'
	validates_presence_of :city, :message => '^Ingresar ciudad'
	validates_presence_of :state, :message => '^Ingresar estado'
	validates_presence_of :phone, :message => '^Ingresar número de teléfono'
	  
	validates :name, length: { maximum: 30, too_long: '^El nombre excede los %{count} caracteres'}
	validates :address, length: { maximum: 100, too_long: '^La dirección excede los %{count} caracteres'}
	validates :city, length: { maximum: 20, too_long: '^La ciudad excede los %{count} caracteres'}
	validates :state, length: { maximum: 20, too_long: '^El estado excede los %{count} caracteres'}
	validates :phone, length: { in: 6..15, too_short: '^El número debe contener al menos %{count} caracteres', too_long: '^El número excede los %{count} caracteres'}

end
