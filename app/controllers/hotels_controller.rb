class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update]
  # before_action :authenticate!, expect: [:show]
  def index
  	# @hotels = Hotel.all
    @hotels = current_user.hotels

  end

  def show
  	
  end

  def edit
    
  end

  def new
    # owner of the room of course
  	@hotel = current_user.hotels.build
  end

  def create
  	@hotel = current_user.hotels.build(hotel_params)
  	if @hotel.save
  		redirect_to @hotel, notice: "Yayyyyy, Saved! "
  	else
  		render :new
  	end
  end

  def update
  	if @hotel.update(hotel_params)
  		redirect_to @hotel, notice: "Yaaaaay,Updated!"
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
		@hotel = Hotel.find_by_id(params[:id])
	end
	def hotel_params
		params.require(:hotel).permit(:name,:review,:address, :price, :type, :summary)
	end
end
