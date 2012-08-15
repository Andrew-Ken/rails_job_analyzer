class RemoveTermsFromTerminology < ActiveRecord::Migration
  def up
    remove_column :terminologies, :terms
  end

  def down
    add_column :terminologies, :terms, :string
  end
end
