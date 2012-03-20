class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :username
      t.string :full_name

      t.timestamps
    end
  end
end
