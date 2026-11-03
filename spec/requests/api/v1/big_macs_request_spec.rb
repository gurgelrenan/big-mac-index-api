require 'rails_helper'

RSpec.describe 'Big Mac indexes', type: :request do
  def returned_ids
    json_body['data'].map { |item| item['id'].to_i }
  end

  it 'orders all indexes by descending date, then name and id' do
    older = create(:big_mac_index, date: '2019-01-01', name: 'Argentina')
    brazil = create(:big_mac_index, name: 'Brazil')
    argentina = create(:big_mac_index, name: 'Argentina')
    duplicate = create(:big_mac_index, name: 'Argentina')

    get '/api/v1/big_macs'

    expect(response).to have_http_status(:ok)
    expect(returned_ids).to eq([argentina.id, duplicate.id, brazil.id, older.id])
  end

  it 'returns the latest date regardless of insertion order, ordered by name and id' do
    brazil = create(:big_mac_index, name: 'Brazil')
    argentina = create(:big_mac_index, name: 'Argentina')
    duplicate = create(:big_mac_index, name: 'Argentina')
    create(:big_mac_index, date: '2019-01-01')

    get '/api/v1/big_macs/latest'

    expect(response).to have_http_status(:ok)
    expect(returned_ids).to eq([argentina.id, duplicate.id, brazil.id])
  end

  it 'returns an empty list when no indexes exist' do
    get '/api/v1/big_macs/latest'

    expect(response).to have_http_status(:ok)
    expect(json_body['data']).to eq([])
  end
end
