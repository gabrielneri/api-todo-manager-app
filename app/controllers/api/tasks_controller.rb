class Api::TasksController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_task, only: %i[show update status destroy]

  # GET /tasks?visibility=[public, private, all]&status=[not_finished, finished, all]
  def index
    visibility = params[:visibility]
    status = params[:status]

    if visibility == 'all'
      tasks_by_visibility = Task.public_tasks.or(current_api_user.tasks.private_tasks)
    elsif visibility == 'public'
      tasks_by_visibility = Task.public_tasks
    else
      tasks_by_visibility = current_api_user.tasks.private_tasks
    end
    
    if status == 'all'
      @tasks = tasks_by_visibility
    elsif status == 'not_finished'
      @tasks = tasks_by_visibility.not_finished_tasks
    else
      @tasks = tasks_by_visibility.finished_tasks
    end

    render json: @tasks
  end

  # GET /tasks/id
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = current_api_user.tasks.new(task_params)

    if @task.save
      render json: @task, status: :created, location: api_task_url(@task)
    else 
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/id
  def update
    unless @task.finished?
      if @task.update(task_params)
        render json: @task
      else 
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /tasks/id/status
  def status
    if @task.update(status: params[:status])
      render json: @task
    else 
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/id
  def destroy
    @task.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions. 
  def set_task
    @task = current_api_user.tasks.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :status, :visibility)
  end

end
