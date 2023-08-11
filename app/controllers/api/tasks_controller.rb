class Api::TasksController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_task, only: %i[show update destroy]

  # GET /tasks 
  # List all user tasks
  def index
    @tasks = current_api_user.tasks.all
  
    render json: @tasks
  end

  # GET /tasks/id
  def show
    render json: @task
  end

  # GET /tasks/public
  # List all public tasks
  def public
    @tasks = Task.public_tasks

    render json: @tasks
  end

  # GET /tasks/private
  # List all user private tasks
  def private
    @tasks = current_api_user.tasks.private_tasks

    render json: @tasks
  end

  # GET /tasks/all
  # List all public tasks and just the user's private ones
  def all 
    @tasks = Task.public_tasks.or(current_api_user.tasks.private_tasks)

    render json: @tasks
  end

  # GET /tasks/not_finished
  # List all not finished user tasks
  def not_finished
    @tasks = current_api_user.tasks.not_finished_tasks

    render json: @tasks
  end

  # GET /tasks/finished
  # List all finished user tasks
  def finished
    @tasks = current_api_user.tasks.finished_tasks

    render json: @tasks
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
