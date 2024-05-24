require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def setup
    Capybara.server_host = "0.0.0.0"
    Capybara.app_host = "http://#{ IPSocket.getaddress(Socket.gethostname) }" if ENV["SELENIUM_REMOTE_URL"].present?
    super
  end

  url = ENV.fetch("SELENIUM_REMOTE_URL", nil)
  options = if url
    {browser: :remote, url: url}
  else
    {browser: :chrome}
  end

  driven_by :selenium, using: :headless_chrome, options: options, screen_size: [1400, 1400]
end
