class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    UserDecorator.decorate(super || User.new)
  end
end
