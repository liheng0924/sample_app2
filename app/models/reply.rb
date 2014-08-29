class Reply < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user
  #default_scope -> {order('created_at ASC')}  #默认就是按时间正序排列
  validates :remark, presence: true, length: {maximum: 5000}
end
