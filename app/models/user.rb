class User <ApplicationRecord 
  validates_presence_of :email, :name 
  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :password

  has_secure_password
  has_many :viewing_parties
end 