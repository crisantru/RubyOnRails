class User < ActiveRecord::Base    
  belongs_to :staffs

    # Códigos de Auntenticación
    attr_accessor :password
    before_save :encrypt_password
    
    validates_confirmation_of :password, :message => '^Las contraseñas no coinciden'
    validates_presence_of :password, :on => :create, :message => '^Ingresar contraseña'
    validates_presence_of :user_name, :message => '^Ingresar nombre de usuario'
    validates_uniqueness_of :user_name, :message => '^Nombre de usuario ya existe'
    validates_uniqueness_of :staff_id, :message => '^El usuario no puedo relacionarse con este empleado'
    
    def self.authenticate(user_name, password)
        user = find_by_user_name(user_name)
        if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
            user
        else
            nil
        end
    end
    
    def encrypt_password
        if password.present?
            self.password_salt = BCrypt::Engine.generate_salt
            self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)

        end
    end
    # Termina sección de autenticación
end
