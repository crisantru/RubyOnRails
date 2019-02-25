class Stock < ActiveRecord::Base
  has_many :branches

  validates_presence_of :address, :message => '^Debe de existir una dirección'
  validates_presence_of :phone, :message => '^Ingresar número de teléfono'
  validates :address, length: { maximum: 100, too_long: '^La dirección excede los %{count} caracteres'}
  
  validates :phone, length: {
  	in: 6..15 ,
  	too_short: "^El número telefónico debe contener al menos %{count} números",
  	too_long: " ^El número telefónico no debe exceder de %{count} "}
end
