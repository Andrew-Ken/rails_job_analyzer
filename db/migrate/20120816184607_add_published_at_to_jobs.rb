class AddPublishedAtToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :published_at, :date
  end
end
