class Api::V1::RetrosController < ApplicationController
  before_action :set_headers

  def index
    render json: Retro.order(:id)
  end

  def create
    retro = Retro.new(JSON.parse(request.body.read))
    if retro.save
      render json: retro
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def destroy
    retro = Retro.find(params[:id])
    if retro.destroy
      render json: nil
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = "http://localhost:3000"
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
