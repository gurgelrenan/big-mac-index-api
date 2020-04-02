FactoryBot.define do
  factory :big_mac_index do
    date {'2020-01-14' }
    iso_a3 { 'BRA' }
    currency_code { 'BRL' }
    name { 'Brazil' }
    local_price { '19.9' }
    dollar_ex { '4.1419' }
    dollar_price { '4.80455829450252' }
  end
end