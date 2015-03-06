class Tasks::JobStepsController < ApplicationController
  include Wicked::Wizard

  steps :details, :auto_steps, :photos, :confirmation

  def show
    @task = Task.find(params[:task_id])
    @job_category = JobCategory.find(@task.job_category_id)
    @todoitem = @task.todoitems.new
    render_wizard
  end
  def update
    @task = Task.find(params[:task_id])
    @job_category = JobCategory.find(@task.job_category_id)
    @task.update(task_params)
    render_wizard @task
  end
  def create

    @task = Task.create
    redirect_to wizard_path(steps.first, :task_id => @task.id)
  end
  private
  def task_params
    params.require(:task).permit(:wallet_id, :id, :subject, :photos, :description, :deliverables, :zipcode, :rating_required, :no_ratings_required, :price, :content, :tag_list, :task_category, :job_category_id, :local, :task_type, :due_date, todoitems_attributes: [:body, :task_id])
  end

  def finish_wizard_path
    flash[:notice] = "Job successfully posted"
    @task = Task.find(params[:task_id])
    task_path(@task)

  end
end
