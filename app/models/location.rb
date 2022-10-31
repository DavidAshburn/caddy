#used for geolocation of a city in course search, not saved to db
class Location < ApplicationRecord
	geocoded_by :address
	after_validation :geocode
end