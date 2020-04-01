class CreateBigMacIndices < ActiveRecord::Migration[6.0]
  def change
    create_table :big_mac_indices do |t|
      t.date :date
      t.string :iso_a3, limit: 3
      t.string :currency_code, limit: 3
      t.string :name
      t.decimal :local_price
      t.decimal :dollar_ex
      t.decimal :dollar_price
      t.decimal :USD_raw
      t.decimal :EUR_raw
      t.decimal :GBP_raw
      t.decimal :JPY_raw
      t.decimal :CNY_raw
      t.decimal :GDP_dollar
      t.decimal :adj_price
      t.decimal :USD_adjusted
      t.decimal :EUR_adjusted
      t.decimal :GBP_adjusted
      t.decimal :JPY_adjusted
      t.decimal :CNY_adjusted

      t.timestamps
    end
  end
end
