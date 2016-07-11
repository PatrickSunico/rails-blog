class CreateUsers < ActiveRecord::Migration
  def up
    # where users is the table name
    # "users" || :users string or symbols
    create_table "users" || :users do |t|
      # longhand form
      t.column "first_name", :string, :limit => 25

      # shorthand form
      t.string "last_name", :limit => 50
      # if user made account it's email will be the default value for that particular user
      # email should not be null
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40
      t.timestamps

    end
  end

  def down
    drop_table :users
  end
end
