class User < ActiveRecord::Base
  has_many :activities
  has_many :participates
  has_many :activities, through: :participate
end
