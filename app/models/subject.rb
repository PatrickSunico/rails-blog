class Subject < ActiveRecord::Base

  # Subject has many Pages where :pages refers to the Page table
  has_many :pages

  # Validation Requirements
  validates_presence_of :name, :position, :created_at

  # Custom Class Query Methods

  # Checks if records containing whether visible is true/false
  scope :visible, lambda{ where(:visible => true)}
  scope :invisible, lambda {where(:visible => false)}

  # Sorts records in ascending order depending on it's position attributes
  scope :sorted, lambda {order("subjects.position ASC")}

  # sorts records in descending order depending on the date created.
  scope :newest_first, lambda{order("subjects.created_at DESC")}

  #searches through the records for a name resemblance input
  scope :search, lambda {|query|
    where(["name Like ?", "%#{query}"])
  }

end
