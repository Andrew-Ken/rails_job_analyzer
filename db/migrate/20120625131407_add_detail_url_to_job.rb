class AddDetailUrlToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :detail_url, :string
  end
end
