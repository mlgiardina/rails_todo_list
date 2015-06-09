class Todo < ActiveRecord::Base
   def change_from_boolean
    if self.completed == true
      "complete"
    else
      "incomplete"
    end
  end
end
