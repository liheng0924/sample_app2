class SessionsController < ApplicationController
 def new
 end

 def create
  user=User.find_by(email: params[:session][:email].downcase)
  if user
   if user.authenticate(params[:session][:password])
    # Sign the user in and redirect to the user's show page.
    sign_in user
    #redirect_to user
    redirect_back_or(root_path)
   else
    #flash[:error]='Invalid password value !'
    flash.now[:error]='Invalid password value !'
    render 'new' 
   end
  else
   flash.now[:error]='Invalid email value !' 
   render 'new'
  end
 end

 def destroy
  sign_out
  #redirect_to signin_path
  redirect_to root_path
 end
end
