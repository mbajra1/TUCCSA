class ErrorsController < ApplicationController

  # dynamically render the error page
  def show
    render status_code.to_s, :status => status_code
  end

  # get the status code
  protected
  def status_code
    params[:code] || 500
  end

end
