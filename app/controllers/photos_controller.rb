class PhotoController < ApplicationController
	def destroy
		@photo = Photo.find(params[:id])
		hotel = @photo.hotel
		@photo.destroy
		@photos = Photo.where(hotel_id: hotel.id)
		respond_to :js
		
	end
end
