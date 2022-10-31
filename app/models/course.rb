require 'net/http'
require 'digest'
require 'json'

class Course < ApplicationRecord
	has_many :holepins
	has_many :coursekeys

	after_create :get_hole_info

	def layoutlength(tee)
		if tee == 1
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_1_len
			end
		elsif tee == 2
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_2_len
			end
		elsif tee == 3
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_3_len
			end
		elsif tee == 4
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_4_len
			end
		else
			0
		end
	end

	def layoutpar(tee)
		if tee == 1
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_1_par
			end
		elsif tee == 2
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_2_par
			end
		elsif tee == 3
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_3_par
			end
		elsif tee == 4
			self.holepins.reduce(0) do |sum, hole|
				sum + hole.tee_4_par
			end
		else
			0
		end
	end

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
