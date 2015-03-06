class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :owned_jobs, :class_name => Task, :foreign_key => "wallet_id", dependent: :destroy
  has_many :jobs, :class_name => Task, :foreign_key => "runner_id"
  has_many :messages, :foreign_key => "recipient_id"
  has_many :reviews
  has_many :authentications, dependent: :destroy
  has_many :offers, :foreign_key => "recipient_id", dependent: :destroy


  validates_presence_of :first_name, :last_name, :email
  validates_length_of :first_name, :maximum => 15
  validates_length_of :last_name, :maximum => 15

  #validates :phone, length: {minimum: 7, maximum: 10}

  before_save :uppercase_fields
  after_create :send_user_message

  def send_user_message
    Message.create!(:sender_id => 0, :recipient_id => self.id, :subject =>"Welcome to Honey Dew", :body =>"If you would like a tour around, please visit the FAQ Pages")
  end

  def uppercase_fields
    self.first_name.capitalize!
    self.last_name.capitalize!
  end
  def last_initial
    self.last_name[0,1].capitalize
  end
  def first_initial
    self.first_name[0,1].capitalize
  end
  def full_name
    [first_name, last_name].join(' ')
  end
  def private_name
    "#{self.first_name} #{self.last_initial}."
  end
  def full_name=(name)
    elements = name.split(' ')
    self.last_name = elements.delete(elements.last)
    self.first_name = elements.join(" ")
  end
  def all_jobs(status)
    self.owned_jobs.where(:status => status) + self.jobs.where(:status => status)
  end

#for omniauth

  def apply_omniauth(omniauth)

    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :oauth_token => omniauth['credentials']['token'], :oauth_expires_at => omniauth['credentials']['expires_at'])
    self.email = omniauth['info']['email'] if email.blank?
    self.first_name = omniauth['info']['first_name'] if first_name.blank?
    self.last_name = omniauth['info']['last_name'] if last_name.blank?
    self.image_url = omniauth['info']['image'] if image_url.blank?
    self.username = omniauth['info']['nickname'] if username.blank?
  end
end
