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
class BigMacIndex < ApplicationRecord
end
