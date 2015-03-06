class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  scope :unread, -> {where(:unread => true)}
  scope :defaultindex, -> {order("created_at DESC")} #Changes the Default Sort Order to (Created At.)
  scope :inbox, -> {defaultindex.notchat.where(:deleted => false)}
  scope :deleted, -> {defaultindex.notchat.where(:deleted => true)}
  scope :chatindex, -> {order("created_at ASC")}
  scope :chat, -> {chatindex.where(:message_type => 'chat')}
  scope :notchat, -> {where.not(:message_type => 'chat')}
 # scope :offers, -> {where('message_type=? OR message_type=?','inquiry','acceptedcounteroffer')} Good to keep to know how scopes work! :D, delete when productions comes around.

  before_save :message_redirect


  def message_redirect
    if self.message_type == "inquiry"
      self.wallet_price = self.proposed_price * 1.15 #calculates our percentage
      self.subject = "Congrats, #{User.find(self.sender_id).first_name} wants to complete your task for $#{self.wallet_price}"
      #if self.body.present?
      #self.body = "Message from Runner(#{User.find(self.sender_id).first_name}): #{self.body}. Price:$#{self.wallet_price}.You can accept task and give Runner instructions and your contact info or decline based on reviews / rating. Task will decline in 24 hours."
      #else
      self.body = "#{User.find(self.sender_id).first_name} wants to complete your task for $#{self.wallet_price}. You can accept task and give Runner instructions and your contact info or decline based on reviews / rating. Task will decline in 24 hours."
      #end
    end
    if self.message_type == "counteroffer"
      self.wallet_price = self.proposed_price * 1.15 #calculates our percentage
      self.subject = "#{User.find(self.sender_id).first_name} has made a counteroffer for $#{self.wallet_price}"
      #if self.body.present?
      #self.body = "Message from Runner(#{User.find(self.sender_id).first_name}): #{self.body}. Price:$#{self.wallet_price}.You can accept task and give Runner instructions and your contact info or decline based on reviews / rating. Task will decline in 24 hours."
      #else
      self.body = "#{User.find(self.sender_id).first_name} wants to complete your task for $#{self.wallet_price}. You can accept task and give Runner instructions and your contact info or decline based on reviews / rating. Task will decline in 24 hours. This is for counteroffer btw, change me!!!"
      #end
    end
    if self.message_type == "acceptedcounteroffer"
      self.wallet_price = self.proposed_price * 1.15 #calculates our percentage
      self.subject = "#{User.find(self.sender_id).first_name} has accepted your counteroffer for $#{self.wallet_price}"
      #if self.body.present?
      #self.body = "Message from Runner(#{User.find(self.sender_id).first_name}): #{self.body}. Price:$#{self.wallet_price}.You can accept task and give Runner instructions and your contact info or decline based on reviews / rating. Task will decline in 24 hours."
      #else
      self.body = "#{User.find(self.sender_id).first_name} wants to complete your task for $#{self.wallet_price}."
      #end
    end
    if self.message_type == "decline"
      if self.body.empty?
        self.body = "This is not the end of the world, etc. build up ratings, blah blah"
      end
    end
  end
end
