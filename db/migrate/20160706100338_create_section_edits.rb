class CreateSectionEdits < ActiveRecord::Migration
  def up
    create_table :section_edits do |t|
      # Symbol Assignment
      t.references :admin_user
      t.references :section

      # changes made in the section edit
      t.string :summary
      # OR Using the string assignment

      # t.integer "admin_user"
      # t.integer "section_id"

      t.timestamps
    end
    add_index :section_edits, ["admin_user_id", "section_id"]
  end

  def down
    drop_table :section_edits
  end
end
