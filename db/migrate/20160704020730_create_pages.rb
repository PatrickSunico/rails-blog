class CreatePages < ActiveRecord::Migration

  def up
    create_table :pages do |t|
      # create a foreign key so it allows Pages table to know what the parent "Subject" table is
      t.integer "subject_id"

      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps
    end
    # look up primary key in pages table
    add_index('pages','subject_id')

    # look up permalinks in pages table
    add_index('pages','permalink')
  end

  def down
    drop_table :pages
  end

end
