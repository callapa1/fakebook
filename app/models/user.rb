class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Registration validations
  validates :name, presence: true
  validates :country, presence: true
  validates :age, presence: true, numericality:{only_integer: true, 
             greater_than_or_equal_to: 13, less_than_or_equal_to: 118 }
  validates :email, presence: true, uniqueness: true

  # Avatar
  has_one_attached :avatar, dependent: :destroy

  # Posts
  has_many :posts, dependent: :destroy

  # Likes
  has_many :active_likes, class_name: "Like", foreign_key: :liker_id, dependent: :destroy
  has_many :liked_posts, through: :active_likes, source: :liked, dependent: :destroy

  # Comments
  has_many :comments, dependent: :destroy

  # Friend invitations
  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, -> { where confirmed: false },
            class_name: "Invitation", foreign_key: "friend_id", dependent: :destroy
  has_many :sent_invitations, -> { where confirmed: false },
            class_name: "Invitation", foreign_key: "user_id", dependent: :destroy

  # Likes methods
  def like(post)
    active_likes.create(liker_id: self, liked_id: post)
  end

  # Friend methods
  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_got_invitation + friends_i_sent_invitation
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def send_invitation(user)
    invitations.create(friend_id: user.id)
  end

  def confirm_invitation(invitation)
    invitation.confirmed = true
  end
end