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
    all_todos = Todo.all
    Todo.create(body: params[:body])
    respond_to do |format|
      format.html do
        render 'index.html.erb', locals: { todos: all_todos }
      end
      format.json do
        render json: all_todos
      end
    end
  end

  def show
    begin
      todo = Todo.find(params[:id])
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
      all_todos = Todo.all
      Todo.delete(params[:id])
      respond_to do |format|
        format.html do
          render 'index.html.erb', locals: { todos: all_todos }
        end
        format.json do
          render json: all_todos
        end
      end
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: 404
    rescue StandardError => error
      render json: { error: error.message }, status: 422
    end
  end

  def update
    begin
      todo = Todo.find(params[:id])
      todo.update(completed: params[:completed])
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

end
