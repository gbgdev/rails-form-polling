class PagesController < ApplicationController
  def index; end

  def register
    worker_id = RegistrationWorker.perform_async(params)

    render json: { success: true, request_id: worker_id }
  end

  def register_check
    request_id = params['request_id']
    status = Sidekiq::Status::status(request_id)

    response = { status: status }

    if status == :complete
      response['result'] = JSON.parse Redis.current.get(request_id)
    end

    render json: response
  end
end
