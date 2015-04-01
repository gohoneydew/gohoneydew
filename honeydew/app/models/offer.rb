class Offer < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  scope :recent, -> {order("created_at DESC")}
  scope :openstatus, -> {where(:deleted => false)}
  scope :unread, -> {where(:unread => true)}
  scope :active, -> {where(:active => true)}

  ##methods


  def wallet_price
    self.proposed_price * 1.20
  end

  def runner_price
    #TODO: Add logic for price the other way around.
    #number_with_precision(@task.price * 0.85, :precision => 2)
  end

  ##endmethods



end
