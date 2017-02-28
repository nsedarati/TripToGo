class Hotel < ActiveRecord::Base
	belongs_to :user
	has_many :photos
	
	validates :name, presence: true
	validates :address, presence: true
	validates :price, presence: true
	validates :hotel_type, presence: true
	
end
