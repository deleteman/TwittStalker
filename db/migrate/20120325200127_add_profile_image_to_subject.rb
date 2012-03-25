class AddProfileImageToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :profile_image, :string

  end
end
