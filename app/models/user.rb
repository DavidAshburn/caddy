class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :disckeys
  has_many :discs, :through => :disckeys

  has_many :coursekeys
  has_many :courses, :through => :coursekeys
  
end
