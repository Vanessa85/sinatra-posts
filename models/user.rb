class User < ActiveRecord::Base
  has_many :permissions
  has_many :posts
  has_many :logs
end
