class Publics::PlacesController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create]
  before_action :valid_genres,only: [:new,:create,:edit,:update]
  before_action :find_places,only: [:show,:edit,:update]

  def new
    @place = Place.new
    @place.place_images.build # PlaceImageのデータを作成
  end

  def create
    @place = Place.new(place_params)
    @place.place_images.map{|pi| pi.user = current_user} # PlaceImageのuser_idに値を渡す
    if @place.save
      redirect_to @place
    else
      render :new
    end
  end

  def index
    @places = Place.all
  end

  def show
  end

  def edit
    @place.place_images.build # PlaceImageのデータを作成
  end

  def update
    if @place.update(place_params_without_images) && PlaceImage.add_place_images(place_params[:place_images_images],@place,current_user)
      redirect_to @place
    else
      render :edit
    end
  end

  private

  def place_params
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday,place_images_images: [])
  end

  def place_params_without_images
    params.require(:place).permit(:name,:genre_id,:explanation,:postcode,:address,:access,:tel,:url,:hours,:price,:holiday)
  end

  def valid_genres
    @genres = Genre.only_valid
  end

  def find_place
    @place = Place.find(params[:id])
  end
end