class Pokemon < ActiveRecord::Base
  validates :nombre, presence: true
  validates :apodo, presence: true
  validates :peso, presence: true
  validates :altura, presence: true
  validates :vida, presence: true
  validates :image, presence: true
  

  has_many :perteneces, :dependent => :destroy
  has_many :types, through: :perteneces, :dependent => :destroy


  has_attached_file :image, styles: { medium: '200x200>', thumb: '48x48>' }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] #necesario validate
  #para poder guardar la imagen
end
