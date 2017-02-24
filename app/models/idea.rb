class Idea < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_liking, through: :likes, source: :user

  # has_many :events_attending, through: :joins, source: :events
   # User.first.events_attending


  validates :content, length: {minimum: 2}, presence: true
end
