# class Api::V1::TasksController < ApplicationController
# end

module Api
  module V1
    class TasksController < ApplicationController
      def index
        tasks = Task.all
        render json: tasks
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: task, status: :created # 201 Created
        else
          render json: task.errors, status: :unprocessable_entity # 422 Unprocessable Entity
        end
      end

      def update
        task = Task.find(params[:id])
        if task.update(task_params)
          render json: task
        else
          render json: task.errors, status: :unprocessable_entity
        end
      end

      def destroy
        task = Task.find(params[:id])
        task.destroy
        head :no_content # 204 No Content
      end

      private

      def task_params
        params.require(:task).permit(:content, :completed)
      end
    end
  end
end