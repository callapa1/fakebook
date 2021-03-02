class Post < ApplicationRecord
  belongs_to :user
  # Likes
  has_many :passive_likes, class_name: "Like", foreign_key: :liked_id, dependent: :destroy
  has_many :likers, through: :passive_likes, source: :liker, dependent: :destroy

  # Comments
  has_many :comments, dependent: :destroy
end