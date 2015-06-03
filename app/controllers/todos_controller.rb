class TodosController < ApplicationController

  def index
    render json: Todo.all
  end

  def create
    new_todo = Todo.create(body: "new todo")
    render json: new_todo
  end

  def show
    begin
      render json: Todo.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: 404
    rescue StandardError => error
      render json: { error: error.message }, status: 422
    end
  end

end
