class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def update
    @user = User.find(current_user.id)

    #to get reconfirmable email to work again.

      update_params = account_update_params
      # required for settings form to submit when password is left blank
      if update_params[:password].blank?
        [:password,:password_confirmation,:current_password].collect{|p| update_params.delete(p) }
      end
      if update_params[:password].present? and update_params[:current_password].blank?
        [:current_password].collect{|p| update_params.delete(p) }
      end

      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      if update_resource(resource, update_params)
        yield resource if block_given?
        if is_flashing_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
              :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        sign_in resource_name, resource, bypass: true
        respond_with resource, location: user_path(current_user.id)
      else
        clean_up_passwords resource
        respond_with resource, location: user_path(current_user.id)
      end
    end

    protected

    def update_resource(resource, params)
      resource.update_attributes(params)
    end

  private
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
        params[:user][:password].present?
  end
end



