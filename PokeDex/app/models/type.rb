class Type < ActiveRecord::Base
      validates :clase, presence: true

    has_many :perteneces
    has_many :pokemons, through: :perteneces
end
