class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts

  has_many :friendships
  has_many :friends, through: :friendships do
    def alive
      living(true)
    end

    def pending
      living(false)
    end 
  end

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user do
    def alive
      living(true)
    end

    def pending
      living(false)
    end
  end

  has_many :likes
  has_many :comments

  private
  
  def self.living(value)
    where('friendships.alive = ?', value)
  end
end
