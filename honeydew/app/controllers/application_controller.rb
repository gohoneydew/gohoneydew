class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_requested_url
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :flash_to_headers


  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Message'] = flash_message
    response.headers["X-Message-Type"] = flash_type.to_s

    flash.discard # don't want the flash to appear when you reload page
  end

  #this is overriding deviseregistrationcontroller for sign in path and going to the home page of the newly created user.
  def after_sign_in_path_for(resource)
    session[:requested_url] || myriorunner_path
  end
  #this is overriding deviseregistrationcontroller for sign out path
  #this is eventually going to want to go to root_path but for sake of testing it is going here..

  def after_sign_out_path_for(resource)
    root_path
  end
  def after_update_path_for(resource)
    root_path
  end
  private
  def flash_message
    [:error, :warning, :notice].each do |type|
      return flash[type] unless flash[type].blank?
    end
  end

  def flash_type
    [:error, :warning, :notice].each do |type|
      return type unless flash[type].blank?
    end
  end
  def store_requested_url
    #stores last url as long as its not in /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone, :about_me, :phone) }

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :avatar, :phone, :about_me, :current_password)
    end
  end
end


