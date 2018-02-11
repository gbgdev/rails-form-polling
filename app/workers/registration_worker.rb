class RegistrationWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(params)
    sleep 20
    puts "finished"
  end
end
