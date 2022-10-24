class Course < ApplicationRecord
	has_many :holes
	has_many :coursekeys
end
