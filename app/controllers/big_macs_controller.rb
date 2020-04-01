class BigMacsController < ApplicationController
  def index
    render json: { msg: 'success!' }.to_json, status: :ok
  end
end
