class Api::V1::NotesController < ApplicationController
  before_action :set_headers
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    retro = Retro.find(params[:retro_id])
    render json: { notes: Note.where(retro: retro).order(:id), retro: retro.name }
  end

  def create
    note = Note.new(JSON.parse(request.body.read))
    note.update_attributes(retro_id: params[:retro_id])
    if note.save
      render json: note
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def destroy
    note = Note.find(params[:id])
    if note.destroy
      render json: nil
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def update
    note = Note.find(params[:id])
    if note.update_attributes(JSON.parse(request.body.read))
      render json: note
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
