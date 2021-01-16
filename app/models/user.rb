class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  validates :email, uniqueness: true
  has_many :posts, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships do
    def active
      living(true)
    end

    def pending
      living(false)
    end 
  end

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user do
    def active
      living(true)
    end

    def pending
      living(false)
    end
  end

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  private
  
  def self.living(value)
    where('friendships.alive = ?', value)
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, name: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
  end
end
