class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :job
      t.text :memo
      t.integer :rank
      t.boolean :applied

      t.timestamps
    end
    add_index :reviews, :job_id
  end
end
