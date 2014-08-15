class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create,:destroy]
  before_action :correct_user, only: :destroy
  #def index

  #end
  
  def create
    @micropost=current_user.microposts.build(micropost_params)
    respond_to do |format|
      if @micropost.save
        #flash[:success]="Micropost created!"
        #format.html {redirect_to root_url,notice: 'Micropost created!' }
        format.html {redirect_to root_url }
        format.js
      else
        @feed_items=[]
        format.html {render 'static_pages/home'}
        format.js
      end
    end
  end

  def destroy
    @micropost.destroy
    #redirect_to root_url
    respond_to do |format|
      format.html {redirect_to root_url }
      format.js
    end
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end 
    def correct_user
      @micropost=current_user.microposts.find_by(id: params[:id])
      redirected_to root_url if @micropost.nil?
    end
end
