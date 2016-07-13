class Section < ActiveRecord::Base
  has_many :section_edits
  has_many :editors, :through => :section_edits, :class_name => "AdminUser"
  belongs_to :pages

  scope :visible, lambda{ where(:visible => true)}
  scope :invisible, lambda {where(:visible => false)}

  # Sorts records in ascending order depending on it's position attributes
  scope :sorted, lambda {order("sections.position ASC")}

  # sorts records in descending order depending on the date created.
  scope :newest_first, lambda{order("sections.created_at DESC")}

end
