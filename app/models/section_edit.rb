class SectionEdit < ActiveRecord::Base

  # many-to-many association: Rich
  # Specify the name and it's class name, Since we changed the name from AdminUser to "editor" we need to set also the corresponding foreign key for this table, we defined a foreign key inside our migrations file
  # see the create_admin_users_pages_join.rb file
  belongs_to :editors, :class_name => "AdminUser" , :foreign_key => "admin_user_id"

  # Specify the name and it's corresponsing foreign key for this table
  belongs_to :section, :foreign_key => "section_id"
end
