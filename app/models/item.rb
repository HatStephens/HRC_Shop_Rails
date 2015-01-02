class Item < ActiveRecord::Base

  validates :name, length: {maximum: 50}, presence: true
  validates :description, length: {maximum: 250}
  validates :user_id, presence: true

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  # scope :location, -> (location_id) { where location_id: location_id }

end
