class User < ApplicationRecord
  has_secure_password
  has_many :ideas
  has_many :likes
  has_many :ideas, through: :likes

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, length: {minimum: 2}, presence: true
  validates :alias, length: {minimum: 2}, presence: true
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :password, length: {in: 8..20}, :presence => true

before_save do
  self.email.downcase!
  self.name.downcase!
  self.alias.downcase!
end
end
