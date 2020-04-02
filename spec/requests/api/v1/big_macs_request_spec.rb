require 'rails_helper'

RSpec.describe "GET /api/v1/big_macs", type: :request do
  it 'returns a list of all indexes' do
    indexes = create_list(:big_mac_index, 2)
    
    get '/api/v1/big_macs'

    expect(json_body['data'].count).to eq(2)
  end
end
