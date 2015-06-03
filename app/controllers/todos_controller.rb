class TodosController < ApplicationController

  def index
    render json: Todo.all
  end

  def create
    if params[:body].present?
      new_todo = Todo.create(body: params[:body])
    else
      new_todo = Todo.create(body: "new todo")
    end
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

  def destroy
    if Todo.exists?(params[:id])
      Todo.delete(params[:id])
      render json: { message: 'todo deleted' }
    else
      render json: { error: 'Todo not found' }, status: 404
    end
  end

  def update
    if Todo.exists?(params[:id])
      Todo.update(params[:id], completed: params[:completed])
      render json: Todo.find(params[:id])
    else
      render json: { error: 'Todo not found' }, status: 404
    end
  end

end
