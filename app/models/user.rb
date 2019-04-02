class User < ActiveRecord::Base 
    has_secure_password
    validates :name , uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }
    validates :username, uniqueness: { case_sensitive: false }
    has_many :post
end