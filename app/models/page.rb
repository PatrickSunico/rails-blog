class Page < ActiveRecord::Base
  # Page belongs_to or relates to the Subject model
  belongs_to :subject
  # specify the name and it's appending Class model where it belongs to
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

  scope :sorted, lambda {order("pages.position ASC")}
  # scope :newest_first, lambda{order("pages.created_at DESC")}

end
