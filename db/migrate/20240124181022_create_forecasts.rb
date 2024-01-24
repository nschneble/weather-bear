class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.timestamp :date
      t.integer :high
      t.integer :low
      t.string :condition
      t.string :icon
      t.references :lookup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
