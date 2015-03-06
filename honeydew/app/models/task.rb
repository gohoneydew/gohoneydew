class Task < ActiveRecord::Base
  has_one :owner, :class_name => User, :foreign_key => 'wallet_id'
  belongs_to :runners, :class_name => User, :foreign_key => 'runner_id'
  belongs_to :job_category
  has_one :review
  has_many :notes
  has_many :offers
  has_many :messages
  has_many :todoitems, :dependent => :destroy
  accepts_nested_attributes_for :todoitems, :allow_destroy => true
  #serialize :todolist, Array

  validates_presence_of :subject, :description, :job_category

  scope :recent, -> {order("created_at DESC")}
  scope :openstatus, -> {where(:status => 'open')}
  scope :defaultindex, -> {openstatus.order("created_at DESC")}
  scope :subjectdesc, -> {}
  scope :subjectasc, -> {order('subject ASC')}
  scope :notopen, -> {where.not(:status => 'open')}

  acts_as_taggable_on :tags
 # before_save :task_type_change
  #validates_presence_of :price, :if => :task_bid?

  include PgSearch
  pg_search_scope :search, :against => {:subject => 'A', :description => 'B', :zipcode => 'C'},
                  using: {tsearch: {dictionary: "english", prefix: true, anyword: true}},
                  associated_against: {:job_category => :name, user: [:first_name], :tags => :name},
                  ignoring: :accents




  def self.text_search(query)
    if query.present?
      search(query)
    else
      all
    end
  end


  def self.filtered_task_type(type)
    if type
      where(:task_type => type)
    else
      all
    end
  end


  def self.updated_before(time)
    where("updated_at < ?", time)
  end

  def self.status(status)
    if status
      where(status: status)
    else
      all
    end
  end

=begin
  def task_type_change
    if self.price.present?
      self.task_type = "auto"
      self.rating_required = 0 if self.rating_required == nil
      self.no_ratings_required = 0 if self.no_ratings_required == nil
    else
      self.task_type = "bid"
    end
  end
=end

  def runner_price
    runnerprice = self.price * 0.85
  end

  def task_bid?
    self.task_type == "auto" || self.rating_required != nil || self.no_ratings_required!= nil
  end

  def match_task_to_runner(message)
    self.price = message.proposed_price
    self.status = "pending"
    self.runner_id = message.sender_id
    self.save!
  end

  def accept_current_offer(offer)
    self.price = offer.proposed_price
    self.status = 'pending'
    self.runner_id = (offer.sender_id)
    self.save!
  end

  def viewcalc # calculates task views
    if self.views.nil?
      self.views = 1
    else
      self.views +=1
    end
  end

  def average_rating(user) #need to fix the rounding error!!
    if user.reviews.count != 0
    user.reviews.sum(:score) / user.reviews.count
    else
      0
    end
  end
  end
