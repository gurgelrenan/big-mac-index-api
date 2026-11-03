class Api::V1::BigMacsController < ApplicationController
  def index
    indexes = BigMacIndex.order(date: :desc, name: :asc, id: :asc)

    render json: BigMacIndexSerializer.new(indexes).serializable_hash.to_json, status: :ok
  end

  def latest
    last_date = BigMacIndex.maximum(:date)
    indexes = last_date ? BigMacIndex.where(date: last_date).order(name: :asc, id: :asc) : BigMacIndex.none

    render json: BigMacIndexSerializer.new(indexes).serializable_hash.to_json, status: :ok
  end
end
