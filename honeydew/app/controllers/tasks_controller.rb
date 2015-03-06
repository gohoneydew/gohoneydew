class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:edit, :update, :destroy, :new, :create, :show]
  has_scope :status

  def index
    if params[:tag]
      @tag = "#{params[:tag]}"
      @tasks = Task.openstatus.tagged_with(params[:tag]).order(sort_column + " " + sort_direction).filtered_task_type(params[:task_type]).paginate(:per_page => 3, :page => params[:page])
    else
        @query = params[:query]
        @tasks = Task.openstatus.text_search(@query).order(sort_column + " " + sort_direction).filtered_task_type(params[:task_type]).paginate(:per_page => 5, :page => params[:page])

          respond_to do |format|
            format.html
            format.json{render :json => @tasks}
          end
      end
    end

  def update_autotask_with_runner
    @task = Task.find(params[:id])
    @user = User.find(@task.wallet_id)
    @task.update_attributes(:runner_id => current_user.id, :status => "pending")
    respond_to do |format|
      if @task.save
        Message.create(:sender_id => current_user.id, :recipient_id => @user.id, :subject => "#{User.find(current_user).private_name} has accepted your task",
                       :body => "Please provide payment information #{view_context.link_to("here",task_path(@task))}".html_safe, :task_id => @task.id, :message_type => "confimation")
        format.html { redirect_to taskchat_path(@task), notice: 'Awaiting confirmation from wallet' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { redirect_to :back, notice: 'Something went wrong here' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def task_completion
    @task = Task.find(params[:id])
    @task.update_attribute(:status, "closed")
    respond_to do |format|
      if @task.save
        Message.create(:sender_id => current_user.id, :recipient_id => @task.runner_id, :subject => "this is temporary",
                       :body => "This is temporary", :task_id => @task.id, :message_type => "confimation")
        format.html { redirect_to myriorunner_path, notice: 'Thanks for working with Honey Dew' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { redirect_to :back, notice: 'Something went wrong here' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def task_chat
    @task = Task.find(params[:id])
    @tasks = current_user.all_jobs("pending")
    @wallet = @task.wallet_id
    @runner = @task.runner_id
    @messages = @task.messages.chat.all
    @message = Message.new
    @message_last = @messages.last


    if @message_last.present?
      if current_user.id == @message_last.recipient_id
        @message_last.update_attributes(:unread => false)
      end
    end
    @unread_messages = @messages.unread

  end


  def show
    @task = Task.find(params[:id])
    @message = Message.new
    @note = Note.new
    @offer = Offer.new
    unless @task.wallet_id == current_user.id
      @task.update_attribute(:views, "#{@task.viewcalc}")
    end
    @job_category = JobCategory.find_by_id(@task.job_category_id)
    @wallet = User.find(@task.wallet_id)
    @runner = User.find(@task.runner_id) if @task.status == "pending" || @task.status == "closed"
    @offers = @task.offers.recent.openstatus.all
    @review = Review.new if @task.status == "closed"

  end

  # GET /tasks/new
  def new
    @task = Task.new
  end
  def my_owned_jobs
    @user = User.find(params[:id])
      @query = params[:query]
      @status = params[:status]
      @tasks = @user.owned_jobs.text_search(@query).order(sort_column + " " + sort_direction).filtered_task_type(params[:task_type]).status(params[:status]).paginate(:per_page => 7 , :page => params[:page])

      respond_to do |format|
        format.html
        format.json{render :json => @tasks}
      end
  end
  def my_jobs
    @user = User.find(params[:id])
    @query = params[:query]
    @status = params[:status]
    @tasks = @user.jobs.text_search(@query).order(sort_column + " " + sort_direction).filtered_task_type(params[:task_type]).status(params[:status]).paginate(:per_page => 7 , :page => params[:page])

    respond_to do |format|
      format.html
      format.json{render :json => @tasks}
    end
  end

  # GET /tasks/1/edit
  def edit
  end


  def update_task_with_runner
    @message = Message.find(params[:id])
    @task = Task.find(@message.task_id)
    @runner = User.find(@message.sender_id)
    @wallet = User.find(@task.wallet_id)
    @task.update_attributes(:runner_id => @runner, :price => @message.proposed_price)

    #task.update_attribute(:runner_id => message.sender_id, :price => message.proposed_price)
  end
    def accept_offer
    @offer = Offer.find(params[:id])
    @task = Task.find(@offer.task_id)
    @runner = User.find(@offer.sender_id)
    @task.accept_current_offer(@offer)
    @offer.update_attributes(:active => false)
#sets user and information tied to task
    respond_to do |format|
      if @task.save
        Message.create(:sender_id => 0, :recipient_id => @runner.id, :subject => "congratulations, you are now the runner",
                       :body => "#{current_user.first_name} has accepted your offer", :task_id => @task.id, :message_type => "confimation")
        format.html { redirect_to taskchat_path(@task), notice: "Runner Notified"  }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { redirect_to myoffers_path(current_user), error: 'Something Went Wrong' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
    end
  def decline_offer
    @offer = Offer.find(params[:id])
    @task = Task.find(@offer.task_id)
    @runner = User.find(@offer.sender_id)
#sets user and information tied to task
      @offer.update_attributes(:deleted => true, :active => false)
      if @offer.save
        flash[:notice] = "User Notified"
        Message.create(:sender_id => 0, :recipient_id => @runner.id, :subject => "Sorry, your offer has been declined",
                       :body => "#{current_user.first_name} has declined your offer, sorry!", :task_id => @task.id, :message_type => "decline")
        redirect_to myoffers_path(current_user.id)
    else
      redirect_to inbox_path(current_user)
      flash[:error] = "Something went wrong"
    end
  end
  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.wallet_id = current_user.id


    respond_to do |format|
      if @task.save
        format.html { redirect_to task_job_steps_path(:task_id => @task.id) }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new', error: 'Something Went Wrong' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to myriorunner_path, notice: 'Task was deleted' }
      format.json { head :no_content }
    end
  end

  def tags
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?" , "%#{params[:q]}%")
    respond_to do |format|
      format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name}}}
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end
  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  #def task_params
  # params[:task]
  #end
  def task_params
    params.require(:task).permit(:wallet_id, :id, :subject, :description, :deliverables, :zipcode, :rating_required, :no_ratings_required, :price, :content, :tag_list, :task_category, :job_category_id, :local, :task_type, :due_date, todoitems_attributes: [:body, :task_id] )
  end
end
