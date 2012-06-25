class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :company
      t.string :location
      t.text :content
      t.string :web_source

      t.timestamps
    end
  end
end
