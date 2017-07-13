class List < ActiveRecord::Base
  has_many :posts
  has_many :permissions
  has_many :logs

  def self.new_list(name, shared_with, user)
    list = List.create(name: name, shared_with: shared_with)
    Permission.create(list: list, user: user, permission_level: 'READ_WRITE')
    return list
  end
end
