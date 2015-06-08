class TodosController < ApplicationController

  def index
    all_todos = Todo.all
    respond_to do |format|
      format.html do
        render 'index.html.erb', locals: { todos: all_todos }
      end
      format.json do
        render json: all_todos
      end
    end
  end

  def create
    if params[:body].present?
      new_todo = Todo.create(body: params[:body])
    else
      new_todo = Todo.create(body: "")
    end
      render json: new_todo
  end

  def show
    todo = Todo.find(params[:id])
    begin
      respond_to do |format|
        format.html do
          render 'show.html.erb', locals: { single_todo: todo }
        end
        format.json do
          render json: todo
        end
      end
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: 404
    rescue StandardError => error
      render json: { error: error.message }, status: 422
    end
  end

  def destroy
    begin
      Todo.delete(params[:id])
      render json: { message: "todo deleted or didn't exist" }
    rescue StandardError => error
      render json: { error: error.message }, status: 422
    end
  end

  def update
    begin
      Todo.update(params[:id], completed: params[:completed])
      render json: Todo.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: 404
    rescue StandardError => error
      render json: { error: error.message }, status: 422
    end
  end

end
