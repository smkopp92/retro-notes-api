Rails.application.config.middleware.use OmniAuth::Builder do
  provider :launch_pass, ENV['LP_CLIENT'], ENV['LP_SECRET'],
    client_options: {
      site: "http://localhost:3001/"
    },
    authorize_params: {
      signing_up: nil
    }
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
