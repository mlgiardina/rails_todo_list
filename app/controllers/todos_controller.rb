class TodosController < ApplicationController

  def index
    render json: Todo.all
  end

  def create
    new_todo = Todo.create(body: "new todo")
    render json: new_todo
  end

end
