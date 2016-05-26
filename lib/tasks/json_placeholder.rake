require 'net/http'

desc "Fetch JSON data from jsonplaceholder.typicode.com"

namespace :json_placeholder do

  task :fetch_all => [:fetch_users, :fetch_albums, :fetch_photos]

  task :fetch_albums => :environment do
    albums_data = get_path '/albums'

    create_and_update_albums albums_data
  end

  task :fetch_photos => :environment do
    photos_data = get_path '/photos'

    create_and_update_photos photos_data
  end

  task :fetch_users => :environment do
    users_data = get_path '/users'

    create_and_update_users users_data
  end
end

def create_and_update_albums albums_data
  albums_data.each do |album_data|
    prep_album_data album_data

    Album.find_or_initialize_by(id: album_data["id"]).tap do |album|
      album.update! album_data
    end
  end
end

def create_and_update_photos photos_data
  photos_data.each do |photo_data|
    prep_photo_data photo_data

    Photo.find_or_initialize_by(id: photo_data["id"]).tap do |photo|
      photo.update! photo_data
    end
  end
end

def create_and_update_users users_data
  users_data.each do |user_data|
    address_data = user_data.delete "address"
    prep_address_data address_data
    prep_user_data user_data

    User.find_or_initialize_by(id: user_data["id"]).tap do |user|
      user.update! user_data
      # FIXME This assumes we support only 1 address:
      user.addresses.first_or_create! address_data
    end
  end
end

def prep_address_data address_data
  address_data.delete "geo"
end

def prep_album_data album_data
  album_data["user_id"] = album_data.delete "userId"
end

def prep_photo_data photo_data
  photo_data["album_id"] = photo_data.delete "albumId"
end

def prep_user_data user_data
  user_data.delete "company"
end

def get_path path
  root = 'http://jsonplaceholder.typicode.com'
  url = URI.parse(root + path)
  req = Net::HTTP::Get.new url.to_s
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request req
  end
  JSON.parse res.body
end
