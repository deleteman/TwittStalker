class AddTweetDateToSubjectCheckIn < ActiveRecord::Migration
  def change
    add_column :subject_check_ins, :tweet_date, :date

  end
end
