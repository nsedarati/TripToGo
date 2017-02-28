class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update]
  # before_action :authenticate!, expect: [:show]
  def index
  	# @hotels = Hotel.all
    @hotels = current_user.hotels

  end

  def show
  	@photos = @hotel.photos
  end

  def edit
    if current_user.id == @hotel.user.id
    @photos = @hotel.photos
  else
    redirect_to root_path, notice: "Biiiiiiiiib, don't access"
  end
end

  def new
    # owner of the hotel of course
  	@hotel = current_user.hotels.build
  end

  def create
  	@hotel = current_user.hotels.build(hotel_params)
  	if @hotel.save
      if params[:images]
        params[:images].each do |image| 
          @hotel.photos.create(image: image)
        end
      end
      
      @photos = @hotel.photos
  		redirect_to edit_hotel_path(@hotel) , notice: "Yayyyyy, Saved! "
  	else
  		render :new
  	end
  end

  def update
  	if @hotel.update(hotel_params)
      if params[:images]
        params[:images].each do |image| 
          @hotel.photos.create(image: image)
        end
      end
      redirect_to edit_hotel_path(@hotel) , notice: "Yayyyyy, Updated! "
  		
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
		params.require(:hotel).permit(:name,:review,:address, :price, :hotel_type, :summary )
	end
end
