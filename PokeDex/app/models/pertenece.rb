class Pertenece < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :type
end
