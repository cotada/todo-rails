module Api
  module V1
    class TasksController < ApplicationController
      # GET /api/v1/tasks
      def index
        tasks = Task.order(completed: :asc)
                   .order(Arel.sql('CASE WHEN completed = true THEN 0 ELSE priority END DESC'))
                   .order(created_at: :desc)
        render json: tasks
      end

      # GET /api/v1/tasks/:id
      def show
        task = Task.find(params[:id])
        render json: task
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Task not found' }, status: :not_found
      end

      # POST /api/v1/tasks
      def create
        task = Task.new(task_params)
        if task.save
          render json: task, status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/tasks/:id
      def update
        task = Task.find(params[:id])
        if task.update(task_params)
          render json: task
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Task not found' }, status: :not_found
      end

      # DELETE /api/v1/tasks/:id
      def destroy
        task = Task.find(params[:id])
        task.destroy
        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Task not found' }, status: :not_found
      end

      private

      def task_params
        params.require(:task).permit(:title, :description, :completed, :priority)
      end
    end
  end
end