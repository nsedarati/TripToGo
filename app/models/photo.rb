class Photo < ActiveRecord::Base
  belongs_to :hotel

  has_attached_file :image,
  path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:filename',
   styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
