class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks
  def index
    @tasks = Task.all
    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    Rails.logger.info "Update params: #{params.inspect}"
    Rails.logger.info "Task params: #{task_params.inspect}"
    
    if @task.update(task_params)
      Rails.logger.info "Updated task: #{@task.inspect}"
      render json: @task
    else
      Rails.logger.info "Task errors: #{@task.errors.inspect}"
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy!
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :completed, :priority)
    end
end
