class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:show,:create,:destroy]
  before_action :correct_user, only: :destroy
  #def index

  #end
  def show
    @micropost=Micropost.find(params[:id])
    @replies=@micropost.replies.paginate(page: params[:page])
    @reply=@micropost.replies.build    #for new reply
    #@reply=@micropost.replies.first    #for new reply
  end

  def edit
    @micropost=Micropost.find(params[:id])
  end

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

  def update
    @micropost=Micropost.find(params[:id])
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @micropost.destroy
    #redirect_to root_url
    respond_to do |format|
      format.html {redirect_to root_url ,notice: "You've delete the micropost successfull!"}
      format.js
    end
  end

  private
    def micropost_params
      params.require(:micropost).permit(:title,:content)
    end 
    def correct_user
      @micropost=current_user.microposts.find_by(id: params[:id])
      redirected_to root_url if @micropost.nil?
    end
end
