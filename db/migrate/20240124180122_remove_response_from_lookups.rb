class RemoveResponseFromLookups < ActiveRecord::Migration[7.1]
  def change
    safety_assured { remove_column :lookups, :response }
  end
end
