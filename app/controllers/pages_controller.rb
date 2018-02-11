class PagesController < ApplicationController
  def index
  end

  def register
    redirect_to action: 'index'
  end
end
