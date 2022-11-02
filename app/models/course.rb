require 'net/http'
require 'digest'
require 'json'

class Course < ApplicationRecord
	has_many :holepins
	has_many :coursekeys
	has_many :cards

	after_create :get_hole_info, :check_colors

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
		if info.count < 18 && info.count > 9
			while info.count > 8
				info.pop()
			end
			self.holes = 9
			self.save
		end
		if info.count > 18
			while info.count > 18
				info.pop()
			end
			self.holes = 18
			self.save
		end
		self.holepins.create!(info)
	end

	#this corrects for courses that have a blank tee color on file in the DGCR API
	def check_colors
		checker = self.holepins[0]

		if checker.tee_1_len != 0 && self.tee_1_clr == ""
			self.tee_1_clr = "FFFFFF"
		end

		if checker.tee_2_len != 0 && self.tee_2_clr == ""
			self.tee_2_clr = "FFFFFF"
		end

		if checker.tee_3_len != 0 && self.tee_3_clr == ""
			self.tee_3_clr = "FFFFFF"
		end

		if checker.tee_4_len != 0 && self.tee_4_clr == ""
			self.tee_4_clr = "FFFFFF"
		end
	end

	def hole_info(id)
		signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}holeinfo"
		uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=holeinfo&id=#{id}&sig=#{signature}")
		response = Net::HTTP.get(uri)
		JSON.parse(response)
	end
end
