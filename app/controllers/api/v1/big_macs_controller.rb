class Api::V1::BigMacsController < ApplicationController
  def index
    indexes = BigMacIndex.all

    render json: BigMacIndexSerializer.new(indexes).serializable_hash.to_json, status: :ok
  end

  def latest
    last_date = BigMacIndex.last.date
    indexes = BigMacIndex.where(date: last_date)

    render json: BigMacIndexSerializer.new(indexes).serializable_hash.to_json, status: :ok
  end
end
