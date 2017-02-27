class Hotel < ActiveRecord::Base
	belongs_to :user
	
	validates :name, presence: true
	validates :address, presence: true
	validates :price, presence: true
	validates :type, presence: true
	
end
