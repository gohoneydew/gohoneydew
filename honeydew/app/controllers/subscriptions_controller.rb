class SubscriptionsController < ApplicationController

  def subscribe

    @list_id = "7b85e7c168"
    gb = Gibbon::API.new

    gb.lists.subscribe({
                           :id => @list_id,
                           :email => {:email => params[:email][:address]}
                       })
    flash[:notice] = "Thanks for subscribing, please check your email to confirm"
    redirect_to :back
  end
end