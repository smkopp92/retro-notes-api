class Api::V1::SlacksController < ApplicationController
  before_action :set_headers

  def show
    Slack::Wrapper.new(ENV["SLACK_TOKEN"]).send(retro_notes,"C71SR1SLC")
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = "https://la-retro-notes.herokuapp.com"
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def retro_notes
    result = "*Notes for #{retro.name}*\n"
    result += ":)\n"
    retro.notes.select{|note| note.emotion == "happy"}.each do |note|
      result += "- #{note.text}\n"
    end
    result += ":/\n"
    retro.notes.select{|note| note.emotion == "meh"}.each do |note|
      result += "- #{note.text}\n"
    end
    result += ":(\n"
    retro.notes.select{|note| note.emotion == "sad"}.each do |note|
      result += "- #{note.text}\n"
    end
    result
  end

  def retro
    Retro.find(params[:retro_id])
  end
end
