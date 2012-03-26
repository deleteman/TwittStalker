class SubjectController < ApplicationController

  # Searchs for the user on our database and if it isn't there, then
  # it'll send a request to twitter. 
  # If a result comes from twitter, a new "Subject" is saved in the DB
  def search

    username = params[:username]
    subject = Subject.find_by_username(username)
     
    if subject.nil? #If we don't have the user, then we look for it on Twitter
     begin
      twitt_user = Subject.find_on_twitter username
      subject = Subject.new
      subject.full_name = twitt_user.name
      subject.username = username
      subject.profile_image = twitt_user.profile_image_url
     rescue 
      subject = nil
     end

       #If we can save the new subject, then we can get his/her twitts
      if !subject.nil? && subject.save
        subject.get_my_tweets.each do |t|
          chk_in = SubjectCheckIn.new({:subject_id => subject.id})
          chk_in.twitt = t.text
          chk_in.lat = t.geo.coordinates[0]
          chk_in.lng = t.geo.coordinates[1]
          chk_in.tweet_date = t.created_at
          chk_in.save
        end
      end

    end

    respond_to do |format|
      format.html { render :locals => {:subject => subject, :results_found => !subject.nil? } }
    end
  end

  
  
  def update_twitter_data 
    username = params[:username] 

    subject = Subject.find_by_username(username)

    if subject.nil?
      raise 'No subject found on our DB!'
    end
 
    subject.get_my_tweets.each do |t|
      chk_in = SubjectCheckIn.new({:subject_id => subject.id})
      chk_in.twitt = t.text
      chk_in.lat = t.geo.coordinates[0]
      chk_in.lng = t.geo.coordinates[1]
      chk_in.save
    end

    respond_to do |format|
      format.html { render :locals => {:subject => subject} }
    end

  end


end
