class PagesController < ApplicationController
  def index
  end

  def register
    worker_id = RegistrationWorker.perform_async(params)

    render json: { success: true, request_id: worker_id }
  end

  def register_check
    status = Sidekiq::Status::status(params['request_id'])

    render json: { status: status }
  end
end
