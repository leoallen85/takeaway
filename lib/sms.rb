require "twilio-ruby"

class SMS

  TIME_FORMAT = "%H:%M"

  def initialize(config, client: nil)
    @config = config
    @client = client || Twilio::REST::Client.new(config[:account_sid], config[:auth_token])
  end

  def deliver
    args = {
      from: config[:from],
      to: config[:to],
      body: config[:body] % delivery_time
    }

    messages.create(args)
  end

  private

  attr_reader :client, :config

  def messages
    client.messages
  end

  def delivery_time
    (Time.now + 60 * 60).strftime(TIME_FORMAT)
  end
end
