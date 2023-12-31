class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :status, default: 0
      t.integer :visibility, default: 0

      t.timestamps
    end
  end
end
