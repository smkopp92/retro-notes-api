class Slack::Api
  include HTTParty
  base_uri 'https://slack.com/api'

  POST_RETRO = "/chat.postMessage"

  def self.post_retro(data)
    get POST_RETRO, data
  end
end
