class Slack::Wrapper
  @@api = Slack::Api
  cattr_accessor :api

  def initialize(token)
    @token = token
  end

  def send(data,channel)
    data = send_data(message: data, channel: channel)
    query = query_wrap(data)
    api.post_retro query
  end

  private
  attr_reader :token

  def query_wrap(data)
    {
      query: data
    }
  end

  def token_data
    {
      token: token
    }
  end

  def send_data(message:, channel:)
    {
      as_user: true,
      channel: channel,
      text: message
    }.merge(token_data)
  end
end
