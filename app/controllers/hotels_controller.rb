class HotelsController < ApplicationController
  def index
  	@hotels = Hotel.all
  end

  def show
  	@hotel = Hotel.find_by_id(params[:id])
  end

  def new
  	@hotel = current_user.hotels.build
  end

  def create
  	@hotel = current_user.hotels.build(hotel_params)
  	if @hotel.save
  		redirect_to @hotel, notice: "Saved,,,"
  	else
  		render :new
  	end
  end

  def update
  	if @hotel.update(hotel_params)
  		redirect_to @hotel, notice: "Updated,,,"
  	else
  		render :edit
  end
end
	def destroy
		@hotel = Hotel.find(params[:id])
		@hotel.destroy
		redirect_to '/hotels/new', :notice => "Your hotel has been deleted!"
	end
	private
	def set_hotel
		@hotel = Hotel.find(params[:id])
	end
	def hotel_params
		params.require(:hotel).permit(:name,:review,:address)
	end
end
