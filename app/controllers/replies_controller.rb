class RepliesController < ApplicationController
  before_action :signed_in_user, only: [:create,:destroy]
  before_action :correct_user, only: :destroy


  def create
    # @micropost=Micropost.find_by(id: params[:id])  #取不到
    @reply=current_user.replies.build(reply_params)
    # @reply.user_id=current_user.id
    flash[:success]="reply created!"
    respond_to do |format|
      if @reply.save
        #flash[:success]="Micropost created!"
        #format.html {redirect_to root_url,notice: 'Micropost created!' }
        format.html {redirect_to :back }
        format.js
      else
        format.html {render @micropost}
        format.js
      end
    end
  end

  def edit
   @reply=Reply.find_by(id: params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    #@reply = Reply.find_by(id: params[:id])
    @reply = Reply.find_by(id: params[:id])
    flash[:success]="reply was successfully updated!"
    respond_to do |format|
      #if @reply.update_attributes(params[:reply])
      if @reply.update(reply_params)
        format.html { redirect_to :back }
        format.js
      else
        format.html { render @micropost }
        format.js { render @micropost }
      end
    end
  end

  def destroy
    @reply.destroy
    #redirect_to root_url
    respond_to do |format|
      format.html {redirect_to :back }
      format.js
    end
  end

  private
    def reply_params
      params.require(:reply).permit(:remark,:user_id,:micropost_id)
    end 
    def correct_user
      @reply=current_user.replies.find_by(id: params[:id])
      redirected_to :back if @reply.nil?
    end
end
