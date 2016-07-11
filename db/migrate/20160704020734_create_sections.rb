class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      # foreign key for Section table
      t.integer 'page_id'
      t.string 'name'
      t.integer 'position'

      #set visible to false
      t.boolean 'visible', :default => false
      t.string 'content_type'
      t.text 'content'
      t.timestamps
    end
    # index foreign keys from page_id in sections table
    add_index('sections','page_id')
  end
end
