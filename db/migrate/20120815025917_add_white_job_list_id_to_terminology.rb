class AddWhiteJobListIdToTerminology < ActiveRecord::Migration
  def change
    add_column :terminologies, :white_job_list_id, :integer
  end
end
