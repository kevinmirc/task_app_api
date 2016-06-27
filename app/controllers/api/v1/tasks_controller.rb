class Api::V1::TasksController < Api::V1::ApplicationController
  def index
    tasks = Task.all
    render json: tasks, status: 200
  end

  def create
    if !params[:title]
      render json: {errors: ["Missing paramaters: title required"]}, status: 400
    else
      begin
        task = Task.create!(title: params[:title], description: params[:description], author_id: current_user.id)
        render json: task, status: 200
      rescue
        render json: {errors: ["Task not created"]}, status: 500
      end
    end
  end

  def show
    begin
      task = Task.find(params[:id])
      render json: task
    rescue
      render_404_not_found
    end
  end

  def update
    begin
      task = Task.find(params[:id])
      task.update!(params.permit(:title, :description))
      render json: task, status: 200
    rescue
      render_404_not_found
    end
    
  end

  def delete
    begin
      task = Task.find(params[:id])
      task.destroy
      render json: {message: "Task deleted."}, status: 200
    rescue
      render_404_not_found
    end
  end
end