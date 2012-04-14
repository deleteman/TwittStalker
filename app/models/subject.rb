class Subject < ActiveRecord::Base

  has_many :subject_check_ins

  def self.find_on_twitter username
   Twitter.user(username)
  end

  def my_tweeting_locations

    my_coords = []
    subject_check_ins.group(:lat,:lng).count.each do |elem|
      my_coords << {:coords => elem[0] , :count => elem[1]}
    end
    my_coords
  end

  def tweets_by_coords coords
     subject_check_ins.find_all_by_lat_and_lng(coords[:lat], coords[:lng])
  end
  def get_my_tweets source = :twitter

    geo_tweets = []
    if source == :twitter
      # @TODO: Change this so we can get as many tweets as possible
      10.times do |p| #get the last XX (max) tweets
        Twitter.user_timeline(username, :page => p + 1, :count => 50).each do |t|
          if !t.geo.nil?
            geo_tweets << t
          end
        end
      end
    else
      geo_tweets = self.subject_check_ins
    end
    geo_tweets 
  end

  #
  #def tweets_by_timeperiod tp
  #  if tp == :morning
  #    subject_check_ins.where()
  #  end
  #
  #end
end
