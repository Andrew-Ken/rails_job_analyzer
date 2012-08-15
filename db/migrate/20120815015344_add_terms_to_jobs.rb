class AddTermsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :terms, :string
  end
end
