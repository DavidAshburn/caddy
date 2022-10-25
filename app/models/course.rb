class Course < ApplicationRecord
	has_many :holepins
	has_many :coursekeys
end
