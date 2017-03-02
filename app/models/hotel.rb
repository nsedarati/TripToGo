class Hotel < ActiveRecord::Base
	belongs_to :user
	has_many :photos
	
	geocoded_by :address 
	after_validation :geocode, if: :address_changed?
	
	validates :name, presence: true
	validates :address, presence: true
	validates :price, presence: true
	validates :hotel_type, presence: true
	
end
