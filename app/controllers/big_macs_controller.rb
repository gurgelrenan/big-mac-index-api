class BigMacsController < ApplicationController
  def index
    indexes = BigMacIndex.all

    render json: BigMacIndexSerializer.new(indexes).serializable_hash.to_json, status: :ok
  end
end
