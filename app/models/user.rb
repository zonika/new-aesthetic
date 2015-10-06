class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :works

  include PgSearch

  has_many :curator_works, :foreign_key => "curator_id"
  has_many :pieces, through: :curator_works, :class_name => "Work"

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                 dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  def index
    @users = User.all
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                  WHERE  follower_id = :user_id"
    @works = Work.where("user_id IN (#{following_ids})
                  OR user_id = :user_id", user_id: id)
    @works.order('created_at DESC')
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def self.random_user
    User.where(artist: true).where.not(masterpiece: nil).sample
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
