class CreateWhiteJobLists < ActiveRecord::Migration
  def change
    create_table :white_job_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
