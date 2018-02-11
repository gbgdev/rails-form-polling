class PagesController < ApplicationController
  def index
  end

  def register
    worker_id = RegistrationWorker.perform_async(params)

    respond_to do |format|
      format.json do
        render json: { success: true, request_id: worker_id }
      end
    end
  end

  def register_check
    status = Sidekiq::Status::status(params['request_id'])

    respond_to do |format|
      format.json do
        render json: { status: status }
      end
    end
  end
end
