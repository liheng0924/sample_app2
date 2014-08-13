module SessionsHelper


 def sign_in(user)
  remember_token=User.new_remember_token
  cookies.permanent[:remember_token]=remember_token
  user.update_attribute(:remember_token,User.encrypt(remember_token))
  self.current_user=user
 end

 def signed_in?
  !current_user.nil?
 end

 def current_user=(user)
  @current_user=user
 end
 
 def current_user?(user)
  current_user==user
 end

 def signed_in_user
   store_location  # store url before signin
   redirect_to signin_path, notice: "Please sign in." unless signed_in?
   # unless signed_in?
   # flash[:notice] = "Please sign in."
   # redirect_to signin_url
   # end
  end

 def current_user
  remember_token = User.encrypt(cookies[:remember_token])
  @current_user ||= User.find_by(remember_token: remember_token)
 end
 def sign_out
  #current_user=nil
  #cookies.permanent[:remember_token]=""
  self.current_user=nil
  cookies.delete(:remember_token)
 end

  #For redirect page after signin
 def redirect_back_or(default)
  redirect_to(session[:return_to] || default)
  session.delete(:return_to)
 end
 def store_location
  session[:return_to]=request.fullpath
 end
end
