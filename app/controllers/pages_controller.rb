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
  end
end
