class PlaceImage < ApplicationRecord
  belongs_to :place
  belongs_to :user

  attachment :image


  def self.add_place_images(params,place,user) #既存のPlaceに追加するときだけ使う
    params.each do |image|
      unless image == "[]" #不適切なデータははじく
        new_image = place.place_images.new(image: image)
        new_image.user = user
        new_image.save
      end
    end
  end

end