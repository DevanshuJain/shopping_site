class ApplicationController < ActionController::Base
# protect_from_forgery with: :exception
  before_action :authenticate_user!
  protect_from_forgery :except => :webhook

  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
