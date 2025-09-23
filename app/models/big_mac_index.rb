# == Schema Information
#
# Table name: big_mac_indices
#
#  id            :integer          not null, primary key
#  date          :date
#  iso_a3        :string(3)
#  currency_code :string(3)
#  name          :string
#  local_price   :decimal(, )
#  dollar_ex     :decimal(, )
#  dollar_price  :decimal(, )
#  USD_raw       :decimal(, )
#  EUR_raw       :decimal(, )
#  GBP_raw       :decimal(, )
#  JPY_raw       :decimal(, )
#  CNY_raw       :decimal(, )
#  GDP_dollar    :decimal(, )
#  adj_price     :decimal(, )
#  USD_adjusted  :decimal(, )
#  EUR_adjusted  :decimal(, )
#  GBP_adjusted  :decimal(, )
#  JPY_adjusted  :decimal(, )
#  CNY_adjusted  :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class BigMacIndex < ApplicationRecord
end
