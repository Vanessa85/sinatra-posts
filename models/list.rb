class List < ActiveRecord::Base
  has_many :posts
  has_many :permissions
  has_many :logs
end
