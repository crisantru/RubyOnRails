class Client < ActiveRecord::Base
  has_many :bills

  validates_presence_of :name, :message => '^Debe especificar el nombre'
  validates_presence_of :rfc, :message => 'obligatorio'
  validates_presence_of :address, :message => '^Se debe especificar una dirección'
  validates_presence_of :phone, :message => '^Ingresar número telefónico'
  validates_presence_of :email, :message => 'obligatorio'
  validates_presence_of :client_type, :message => '^Seleccionar tipo de cliente'

  validates :name, length: { maximum: 60, too_long: '^El nombre no debe exceder los %{count} caracteres' }
  validates :address, length: { maximum: 100, too_long: '^El nombre no debe exceder los %{count} caracteres' }
  validates :rfc, length: { in: 12..13, too_short: 'debe contener al menos %{count} caracteres', too_long: 'debe contener no mas de %{count} caracteres' }

  validates :phone, length: {
  	in: 6..15 ,
  	too_short: "^El número telefónico debe contener al menos %{count} números",
  	too_long: "^El número telefónico no debe exceder de %{count} " }

end
