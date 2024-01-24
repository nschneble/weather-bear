class AddConditionsToLookups < ActiveRecord::Migration[7.1]
  def change
    add_column :lookups, :scale, :string
    add_column :lookups, :temperature, :integer
    add_column :lookups, :high, :integer
    add_column :lookups, :low, :integer
    add_column :lookups, :condition, :string
    add_column :lookups, :icon, :string
  end
end
