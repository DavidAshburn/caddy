require 'net/http'
require 'digest'
require 'json'

#NY and Ontario Canada only for test version of API
module DgcrHelper
	#pass in course ID
	def crse_info(id)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}crseinfo"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=crseinfo&id=#{id}&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response, object_class: Course)
	end

	def hole_info(id)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}holeinfo"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=holeinfo&id=#{id}&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response)
	end

	def crse_photo(id)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}crsephoto"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=crsephoto&id=#{id}&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response)
	end

	def near_box(trlat, trlon, bllat, bllon)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}near_box"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=near_box&tr_lat=#{trlat}&tr_lon=#{trlon}&bl_lat=#{bllat}&bl_lon=#{bllong}&limit=25&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response)
	end

	def near_rad(lat, lon)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}near_rad"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=near_rad&lat=#{lat}&lon=#{lon}&limit=24&rad=10&sig=#{signature}")
		response = Net::HTTP.get(uri)
		list = JSON.parse(response)
		courses = Array.new
		list.each do |item|
			courses.push(Course.new(item.except("distance")))
		end
		return courses
	end

	def find_name(moniker)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}findname"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=findname&name=#{moniker}&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response)
	end

	#two letter country abbreviations, US/CA
	def find_loc(city, state, country)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}findloc"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=findloc&city=#{city}&state=#{state}&country=#{country}&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response, object_class: Course)
	end

	def find_zip(zip, rad)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}findzip"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=findzip&zip=#{zip}&rad=#{rad}&limit=25&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response)
	end
end