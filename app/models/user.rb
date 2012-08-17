class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_many :reviews
  has_secure_password
  validates_confirmation_of :password 
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_presence_of :email
end
