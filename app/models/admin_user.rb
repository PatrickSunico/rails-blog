class AdminUser < ActiveRecord::Base

  # Enables password authentication inside our AdminUsers Model
  has_secure_password

  # To configure a different table name
  #self.table_name = "admin_users"
  has_and_belongs_to_many :pages

  # AdminUser has_many section_edits;
  # many-to-many Rich
  has_many :section_edits

  # since we made a rich join already, AdminUser has_many sections inside our section_edits table
  has_many :sections, :through => :section_edits

end
