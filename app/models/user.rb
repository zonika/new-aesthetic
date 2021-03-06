class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  include PgSearch
  multisearchable against: [:first_name,:last_name]

  has_many :works
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

  acts_as_messageable

  def index
    @users = User.all
  end


  def mailboxer_email(object)
    email
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

  # finds a random user for the front page masterpiece
  def self.random_user
    User.where(artist: true).where.not(masterpiece: nil).sample
  end
  
  # find six random users for the discovery feed
  def self.randomize_six_users
    User.where(artist: true).where.not(masterpiece: nil).sample(6)
  end
  
  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
