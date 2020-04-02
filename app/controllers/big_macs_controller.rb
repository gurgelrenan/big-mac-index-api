class BigMacsController < ApplicationController
  def index
    indexes = BigMacIndex.all

    render json: indexes.to_json, status: :ok
  end
end
