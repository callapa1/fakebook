class Post < ApplicationRecord
  belongs_to :user

  # Likes
  has_many :passive_likes, class_name: "Like", foreign_key: :liked_id
  has_many :likers, through: :passive_likes, source: :liker

  # Comments
  has_many :comments
end