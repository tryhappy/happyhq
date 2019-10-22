json.extract! task, :id, :name, :user_id, :status, :object_type, :object_id, :instructions, :instruction_value, :execute_on, :created_at, :updated_at
json.url task_url(task, format: :json)
