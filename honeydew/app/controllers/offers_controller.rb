class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
  end


  def my_offers
    @user = User.find(params[:id])
    @offers = @user.offers.openstatus.recent.active.all.paginate(:per_page => 5, :page => params[:page])
    @unread_offers = @offers.unread.active.all
  end
  def show
    @user = current_user
    @offer = Offer.find(params[:id])
    @task = Task.find(@offer.task_id)
    @job_category = JobCategory.find_by_id(@task.job_category_id)
    @sender = User.find(@offer.sender_id)
    @recipient = User.find(@offer.recipient_id)
    @offer.update_attributes(:unread => false)
    @offers = @user.offers.openstatus.recent.active.all
    @unread_offers = @offers.unread
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    @offer.sender_id = current_user.id
    @task = Task.find(@offer.task_id)
    @recipient = User.find(@task.wallet_id)
    @offer.recipient_id = @recipient.id
    respond_to do |format|
      if @offer.save
        Message.create(:sender_id => current_user.id, :recipient_id => @recipient.id, :task_id => @task.id, :message_type => "proposal", :subject => "You have a new offer on job # #{@task.id}", :body => "See offer #{view_context.link_to("here",offer_path(@offer))}".html_safe)
        format.html { redirect_to myriorunner_path, notice: 'Offer was submitted.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { redirect_to @task, notice: 'Something Went Wrong.' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:subject, :task_id, :sender_id, :recipient_id, :proposed_price, :body, :status, :unread, :deleted)
    end
end
