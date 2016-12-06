class SendBiliJob < ActiveJob::Base
  queue_as :messages

  def perform(content, topic)
    Yunba.send(content, topic)
  end
  
end
