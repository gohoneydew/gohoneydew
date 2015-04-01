class SubscriptionsController < ApplicationController

  def subscribe

    @list_id = "7b85e7c168"
    gb = Gibbon::API.new
    gb.throws_exceptions = false

    response = gb.lists.subscribe({
                           :id => @list_id,
                           :email => {:email => params[:email][:address]},
                           :double_optin => false,
                           :send_welcome => true
                       })
    if(response.is_a?(Hash))

      case response['code']
        when 502
          flash[:error] = "Invalid Address!"
          redirect_to :back
        when 214
          flash[:error] = "It seems you are already signed up!"
          redirect_to :back
        else
          flash[:notice] = "Subscription Successful"
          redirect_to betainformation_path
      end
    end
  end
end