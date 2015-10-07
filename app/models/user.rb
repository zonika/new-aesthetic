class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include PgSearch

  has_many :works

  multisearchable against: [:first_name,:last_name]

  has_many :curator_works, :foreign_key => "curator_id"
  has_many :pieces, through: :curator_works, :class_name => "Work"

  acts_as_messageable

  def index
    @users = User.all
  end

  def mailboxer_email(object)
    email
  end

  def self.random_user
    User.where(artist: true).where.not(masterpiece: nil).sample
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
