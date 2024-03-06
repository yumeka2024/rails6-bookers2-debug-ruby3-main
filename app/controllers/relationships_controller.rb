class RelationshipsController < ApplicationController
  
  # def create
  #   user = User.find(params[:user_id])
  #   current_user.follow(user)
  #   redirect_back fallback_location: root_path
  # end
  
  # def destroy
  #   user = User.find(params[:user_id])
  #   current_user.unfollow(user)
  #   redirect_back fallback_location: root_path
  # end
  
  # def follower
    
  # end

  # def followed
    
  # end
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end
