class Api::V1::AssignmentsController < Api::V1::ApplicationController
  def index
    # if params[:offset] || params[:limit]
    # end
    assignments = Assignment.all
    render json: assignments, status: 200
  end

  def show
    begin
      assignment = Assignment.find(params[:id])
      render json: assignment
    rescue
      render_404_not_found
    end
  end

  def create
    begin
      task = Task.find(params[:task_id])
      Assignment.create!(user: User.find(params[:user_id]), task: task)
      render json: task, status: 201
    rescue
      render json: {errors: ["Bad Request"]}, status: 400
    end
  end

  def delete
    begin
      assignment = Assignment.find(params[:id])
      assignment.destroy
      render json: {message: "Assignment deleted."}, status: 200
    rescue
      render_404_not_found
    end
  end
end
