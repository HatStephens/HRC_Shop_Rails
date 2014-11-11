class Item < ActiveRecord::Base

  validates :name, length: {maximum: 50}

end
