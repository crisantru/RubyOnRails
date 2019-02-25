class Product < ActiveRecord::Base
  has_attached_file :image, styles: { medium: '200x200>', thumb: '48x48>' }

  validates :nombre, presence: true
  validates :categoria, presence: true
  validates :descripcion, presence: true
  validates :especificaciones, presence: true
  validates :presentacion, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] #necesario validate
  #para poder guardar la imagen

end
