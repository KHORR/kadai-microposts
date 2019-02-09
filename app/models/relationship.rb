class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User' # 命名規則変更によるfollowの補足説明
end
