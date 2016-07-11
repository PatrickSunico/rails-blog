class CreateAdminUsersPagesJoin < ActiveRecord::Migration
  def up
    # Override the default primary key that rails give out for this table
    create_table :admin_users_pages, :id => false do |t|
      t.integer "admin_user_id"
      t.integer "page_id"
    end

    # to specify which columns we want to index altogether including the table name which is :admin_users_pages
    add_index  :admin_users_pages, ["admin_user_id", "page_id"]
  end

  def down
    drop_table :admin_users_pages
  end

end
