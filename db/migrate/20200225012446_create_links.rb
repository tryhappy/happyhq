class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :master_url
      t.belongs_to :user, null: false, foreign_key: true
      t.string :forward_url
      t.integer :load_count
      t.text :notes

      t.timestamps
    end
  end
end
