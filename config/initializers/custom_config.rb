TWITTER = YAML.load_file("#{RAILS_ROOT}/config/twitter.yml")

Twitter.configure do |config|
  config.consumer_key = TWITTER['consumer_key']
  config.consumer_secret = TWITTER['consumer_secret']
  config.oauth_token = TWITTER['oauth_token']
  config.oauth_token_secret = TWITTER['oauth_token_secret']
end