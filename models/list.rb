class List < ActiveRecord::Base
  has_many :posts
  has_many :permissions
  has_many :logs

  def self.new_list(name, items, user)
    list = List.create(name: name)
    items.each do |item|
      Item.create(name: item[:name], description: item[:description], list: list, user: user)
    end
    Permission.create(list: list, user: user, permission_level: 'READ_WRITE')
    return list
  end
end
