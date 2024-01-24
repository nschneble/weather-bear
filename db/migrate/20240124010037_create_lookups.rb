class CreateLookups < ActiveRecord::Migration[7.1]
  def change
    create_table :lookups do |t|
      t.string :zip_code
      t.timestamp :cached_at
      t.json :response

      t.timestamps
    end
  end
end
