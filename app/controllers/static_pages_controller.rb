class StaticPagesController < ApplicationController
  def home
    #@micropost=current_user.microposts.build if signed_in?
    if signed_in?
      @users=User.all  #用于显示会员个数
      @micropost=current_user.microposts.build    #for new micropost
      @feed_items=current_user.feed.paginate(page: params[:page])  #for microposts list 
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
