class Page < ActiveRecord::Base
  # Page belongs_to or relates to the Subject model
  belongs_to :subject
  # specify the name and it's appending Class model where it belongs to
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  has_many :sections

  scope :visible, lambda{ where(:visible => true)}
  scope :invisible, lambda {where(:visible => false)}

  # Sorts records in ascending order depending on it's position attributes
  scope :sorted, lambda {order("pages.position ASC")}

  # sorts records in descending order depending on the date created.
  scope :newest_first, lambda{order("pages.created_at DESC")}

end
