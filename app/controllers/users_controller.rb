class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index,:edit, :update, :destroy, :following, :followers] 
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :nonew_user, only: [:new,:create]
  before_action :get_all_users     #获取所有用户
  def index
   #@users=User.all
    @users=User.paginate(page: params[:page])
  end
  def show
   @user=User.find(params[:id]) 
   #@microposts=@user.microposts
   @microposts=@user.microposts.paginate(page: params[:page])
  end
  def new
   @user=User.new
  end
  def create
   #@user=User.new(params[:user])
   @user=User.new(user_params)
   if @user.save
     sign_in(@user)    # sign in after sign up
     flash[:success]="Welcome to the Sample App!"
     redirect_to @user
   else
     render 'new'
   end
  end
  
  def edit
   #@user=User.find(params[:id])   # can delete it
  end

  def update
    #@user.update_attributes(user_params)
   @user=User.find(params[:id]) # can delete it
   if @user.update_attributes(user_params)
    # Handle a successful update.
    flash[:success]="Profile updated"
    sign_in @user
    redirect_to @user
   else
    render 'edit'
   end
  end 

  def destroy
   #@user=User.find(params[:id])
   #@user.destroy
   @user=User.find(params[:id]).destroy
   flash[:success]="User '"+@user.name+"' destroyed."
   redirect_to users_url
  end
  def following 
    @title="Following"
    @user=User.find(params[:id])
    @users=@user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  def followers
   @title = "Followers"
   @user = User.find(params[:id])
   @users = @user.followers.paginate(page: params[:page])
   render 'show_follow'
end
   
  private
   def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
   end
   def correct_user
    @user=User.find(params[:id])
    unless current_user?(@user)
     flash[:notice] ="You can not edit others profile!"
     redirect_to root_path
    end
    #redirect_to root_path, notice: "You can not edit others profile!" unless current_user?(@user)
    # redirect_back_or(@user), notice: "You can not edit others profile!" unless current_user?(@user)
   end

   def admin_user
    redirect_to root_path unless current_user.admin?
   end

   def nonew_user
   # flash[:error]="can not sign up after sign in."
    redirect_to root_path , flash[:error]="can not sign up after sign in."  unless current_user.nil?
   end
end
