class User < ApplicationRecord

  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :telefono, presence: true, length: {maximum: 10}
  validates :direccion, presence: true
  validates :genero, presence: true
  validates :fechaNac, presence: true

  #for egresados
 
    #validates :matricula, presence: true, length: {maximum:9}
    #validates :promedio, presence: true, format: { with: /\A\d+\z/, message: "Solo se permiten enteros" }
    #validates :carrera, presence: true
    #validates :fechaEgreso, presence: true
    #validates :empleo, presence: true
    #validates :lugarEmpleo, presence: true
    #validates :areaTrabajo, presence: true
    #validates :idioma, presence: true
  


  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
