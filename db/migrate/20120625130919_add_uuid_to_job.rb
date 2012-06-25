class AddUuidToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :uuid, :integer
  end
end
