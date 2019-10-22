class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.belongs_to :user, null: false, foreign_key: true
      t.string :status
      t.string :object_type
      t.string :object_id
      t.string :instructions
      t.string :instruction_value
      t.datetime :execute_on

      t.timestamps
    end
  end
end
