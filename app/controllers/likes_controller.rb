class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
   # @like = Like.new(user_id: @current_user.id, micropost_id: params[:micropost_id])
   # @like.save
   # flash[:success] = 'いいねをしました。'
   micropost = Micropost.find(params[:micropost_id])
   current_user.like(micropost)
   flash[:success] = 'いいねをしました。'
   # redirect_back + 戻れなかった時の保険でroot_urlに戻る
   redirect_back(fallback_location: root_url)
  end
   
  def destroy
     # @like = Like.find_by(user_id: @current_user.id, micropost_id: params[:micropost_id])
     # @like.save
     # flash[:success] = 'いいねを取り消しました。'
     micropost = Micropost.find(params[:micropost_id])
     current_user.unlike(micropost)
     flash[:success] = 'いいねを取り消しました。'
     redirect_back(fallback_location: root_url)
  end
 
 
end






