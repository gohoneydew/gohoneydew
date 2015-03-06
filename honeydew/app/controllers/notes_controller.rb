class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]


=begin
  before_action :user_task_auth
  def user_task_auth
    @task = Task.find(params[:task_id])
    @runner = User.find(@task.runner_id)
    @wallet = User.find(@task.wallet_id)

    unless current_user.id == @runner.id || current_user.id == @wallet.id
      flash[:error] = "You do not have permitted access, if you believe this is an error, please contact support"
      redirect_to myriorunner_path(current_user.id)
    end

  end
=end

  # GET /notes
  # GET /notes.json
  def index

    @task = Task.find(params[:task_id])
    @otherusernotes = @task.notes.where(:sender_id => current_user.id)
    @mynotes= @task.notes.where(:recipient_id => current_user.id)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @task = Task.find(params[:task])
    @note.task_id = @task.id
    @note.sender_id = current_user.id
    @note.recipient_id = @task.runner_id
    respond_to do |format|
      if @note.save
        format.html { redirect_to @task, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:body)
  end

end
