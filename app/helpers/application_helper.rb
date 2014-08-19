module ApplicationHelper
 def full_title(page_title)
  base_title="Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    base_title+"|"+page_title
    #"#{base_title} | #{page_title}"
  end 
 end
 #获取所有用户，用于徽章显示用户数（控制器内调用的话，需要先引用）
 def get_all_users
   if signed_in?
     @users=User.all  #用于显示会员个数
   end
 end
end
