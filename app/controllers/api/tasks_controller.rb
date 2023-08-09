class Api::TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks
  end

  # GET /tasks/id
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: api_task_url(@task)
    else 
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/id
  def update
    if @task.update(task_params)
      render json: @task
    else 
      render json: @task.erros, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/id
  def destroy
    @task.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions. 
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :status, :visibility)
  end

end
