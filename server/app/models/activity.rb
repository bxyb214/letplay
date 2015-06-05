class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :participates
  has_many :users, through: :participate
end
