class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks 

  has_many :works

  searchkick

  def index
    @users = User.all
  end

  def self.random_user
    User.where(artist: true).where.not(masterpiece: nil).sample
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

end
