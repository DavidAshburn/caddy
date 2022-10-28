require 'net/http'
require 'digest'
require 'json'

class Course < ApplicationRecord
	has_many :holepins
	has_many :coursekeys

	after_create :get_hole_info

	private

	def get_hole_info
		info = hole_info(self.course_id)
		info.shift()
		self.holepins.create!(info)
	end

	def hole_info(id)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}holeinfo"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=holeinfo&id=#{id}&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response)
	end
end
