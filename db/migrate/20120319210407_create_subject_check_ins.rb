class CreateSubjectCheckIns < ActiveRecord::Migration
  def change
    create_table :subject_check_ins do |t|
      t.integer :subject_id
      t.float :lat
      t.float :lng
      t.string :place_name
      t.string :twitt

      t.timestamps
    end
  end
end
