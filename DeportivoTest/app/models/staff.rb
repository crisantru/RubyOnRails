class Staff < ActiveRecord::Base
  belongs_to :staff_types
  has_one :users

  validates_presence_of :name, :message => '^El nombre no puede ir vacío'
  validates_presence_of :last_name, :message => '^Especificar apellidos'
  validates_presence_of :address, :message => '^Especificar dirección'
  validates_presence_of :phone, :message => '^Ingresar numero telefónico'
  validates_presence_of :email, :message => '^Especificar correo electrónico'

  #validate do |staff|
  	#staff.errors.add :base, 'Especificar apellidos' if staff.last_name.blank?
  #end
  
  validates :name, length: { maximum: 30, too_long: '^El nombre debe ser de menos de %{count} caracteres'}
  validates :last_name, length: { maximum: 30, too_long: '^Los apellidos deben ser de menos de %{count} caracteres'}
  validates :address, length: { maximum: 100, too_long: '^La dirección excede los %{count} caracteres' }
  validates :phone, length: { in: 6..15, too_short: '^El teléfono debe contener al menos 6 números', too_long: '^El teléfono excede los %{count} caracteres' }
  validates :email, length: { maximum: 30, too_long: '^El correo electrónico excede los %{count} caracteres'}
end