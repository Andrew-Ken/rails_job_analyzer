class CreateTerminologies < ActiveRecord::Migration
  def change
    create_table :terminologies do |t|
      t.references :job
      t.text :terms

      t.timestamps
    end
    add_index :terminologies, :job_id
  end
end
