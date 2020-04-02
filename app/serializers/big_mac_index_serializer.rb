# == Schema Information
#
# Table name: big_mac_indices
#
#  id            :bigint           not null, primary key
#  CNY_adjusted  :decimal(, )
#  CNY_raw       :decimal(, )
#  EUR_adjusted  :decimal(, )
#  EUR_raw       :decimal(, )
#  GBP_adjusted  :decimal(, )
#  GBP_raw       :decimal(, )
#  GDP_dollar    :decimal(, )
#  JPY_adjusted  :decimal(, )
#  JPY_raw       :decimal(, )
#  USD_adjusted  :decimal(, )
#  USD_raw       :decimal(, )
#  adj_price     :decimal(, )
#  currency_code :string(3)
#  date          :date
#  dollar_ex     :decimal(, )
#  dollar_price  :decimal(, )
#  iso_a3        :string(3)
#  local_price   :decimal(, )
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class BigMacIndexSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :iso_a3, :currency_code, :name, :local_price, 
             :dollar_ex, :dollar_price, :USD_raw, :EUR_raw, :GBP_raw, 
             :JPY_raw, :CNY_raw, :GDP_dollar, :adj_price, :USD_adjusted,
             :EUR_adjusted, :GBP_adjusted, :JPY_adjusted, :CNY_adjusted
end
