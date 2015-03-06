class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end
  def my_messages
    @user = User.find(params[:id])
    @messages = @user.messages.all
  end
  def rr_inbox

    if @unread_messages.present?
      flash[:notice] = "You have #{@unread_messages.count} unread messages"
    end

    @user = User.find(params[:id])
    @messages = @user.messages.inbox.paginate(:per_page => 15, :page => params[:page])
    @unread_messages = current_user.messages.notchat.unread
    @unread_offers = @user.offers.unread
  end
  def rr_sent
    @user = User.find(params[:id])
    @messages = Message.where(:sender_id => current_user.id, :message_type => 'message').paginate(:per_page => 15, :page => params[:page])
    @unread_messages = current_user.messages.notchat.where(:unread => true)
    @unread_offers = @user.offers.unread
  end
  def rr_deleted
    @user = User.find(params[:id])
    @messages = @user.messages.where(:recipient_id => current_user.id).deleted.paginate(:per_page => 15, :page => params[:page])
    @unread_messages = current_user.messages.notchat.where(:unread => true)
    @unread_offers = @user.offers.unread
  end
  def my_chats
    @user = User.find(params[:id])
    @tasks = @user.all_jobs("pending")
  end
  def markasdeleted
    @message = Message.find(params[:id])
    @message.update_attributes(:deleted => true)
    if @message.save
      redirect_to inbox_path(current_user.id)
      flash[:notice] = "Message Marked as Deleted"
    end

  end
  def markasundeleted
    @message = Message.find(params[:id])
    @message.update_attributes(:deleted => false)
    if @message.save
      redirect_to inbox_path(current_user.id)
      flash[:notice] = "Message Returned to Inbox"
    end

  end
  def markasunread
    @message = Message.find(params[:id])
    @message.update_attributes(:unread => true)
    if @message.save
      redirect_to inbox_path(current_user.id)
      flash[:notice] = "Message Marked as Unread"
    end

  end

  def taskconfirmation
    @message = Message.find(params[:id])
    if @message.sender_id == 0
    else
      @user = User.find(@message.sender_id)
    end

    @task = Task.find(@message.task_id)
    if @task.status == "open"
      @task.update_attributes(:price => @message.proposed_price, :status => "pending", :runner_id => @message.sender_id)
      redirect_to task_path(@task)
      if @task.save
        flash[:notice] = "Runner Notified"
        Message.create(:sender_id => current_user.id, :recipient_id => @user.id, :subject => "congrats, you are now the runner",
                       :body => "wait for contact from the seller, congrats", :task_id => @task.id, :message_type => "confimation")
      end
    else
      redirect_to inbox_path(current_user)
      flash[:error] = "Something went wrong"
    end
  end

  def show
    @message = Message.find(params[:id])
    @sender = User.find(@message.sender_id)
    @recipient = User.find(@message.recipient_id)
    @unread_messages = current_user.messages.notchat.where(:unread => true)
    @unread_offers = current_user.offers.unread
    if current_user.id == @message.sender_id || current_user.id == @message.recipient_id #makes sure people can't read other messages and be cute
        @task = Task.find(@message.task_id)
        @user = User.find(@message.sender_id)
      @message.update_attributes(:unread => false)
    else
      flash[:error] = "Invalid Page"
      redirect_to myriorunner_path
    end
  end

  #Working with mailboxes for messages
  def inbox

  end
  def sent

  end
  def deleted

  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id

    respond_to do |format|
  if @message.message_type == "chat"
    if @message.save
      format.html { redirect_to :back }
      format.json { render action: 'show', status: :created, location: @message }
    else
      format.html { render action: 'new', error: 'Something Went Wrong' }
      format.json { render json: @message.errors, status: :unprocessable_entity }
    end
  end
      if @message.save
        format.html { redirect_to myriorunner_path, notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json


  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to mymessages_path(current_user.id) }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only a
  # llow the white list through.
  def message_params
    params.require(:message).permit(:subject, :body, :recipient_id, :sender_id, :task_id, :message_type, :proposed_price)
  end
end
