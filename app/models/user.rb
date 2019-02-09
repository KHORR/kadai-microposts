class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :microposts
    # 自分がフォローしているUserへの参照
    has_many :relationships
    # followingモデルというものはないため、relationships中間テーブルを経由して、follow_idからUserを取得
 　 has_many :followings, through: :relationships, source: :follow
 　 # 自分をフォローしているUserへの逆参照
 　 has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
 　 # followerモデルというものはないため、逆relationships中間テーブルを経由して、user_idからUserを取得
 　 has_many :followers, through: :reverses_of_relationship, source: :user

 def follow(other_user)
    unless self == other_user # フォローしようとしているother_userが自分自身でないかの検証
        self.relationships.find_or_create_by(follow_id: other_user.id)
    end
 end
 
 def unfollow(other_user)
     relationship = self.relationships.find_by(follow_id: other_user.id)
     relationship.destroy if relationship
 end
 
 def following?(other_user)
     self.followings.include?(other_user)
 end
 
 def feed_microposts 
     Micropost.where(user_id: self.following_ids + [self.id])
 end
end
 