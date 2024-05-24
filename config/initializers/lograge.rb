require "lograge/sql/extension"

Rails.application.configure do
  config.lograge.enabled = !Rails.env.in?(%w[development test])
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.logger = ActiveSupport::Logger.new($stdout)
  config.lograge.custom_options = lambda do |event|
    {
      host: event.payload[:request].host,
      ip: event.payload[:request].ip,
      params: event.payload[:params].except("controller", "action", "format", "utf8"),
      request_id: event.payload[:request].request_id,
      subdomain: event.payload[:request].subdomain,
      time: event.time,
    }
  end
end
