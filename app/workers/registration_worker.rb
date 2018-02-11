class RegistrationWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(params)
    sleep 10
    Redis.current.set self.jid, fake_response.to_json
  end

  private

  def fake_response
    {
      error_message: "E-mail already exists."
    }
  end
end
