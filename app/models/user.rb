class User < ActiveRecord::Base
   has_attached_file :avatar,              
     styles: { 
       large: "600x600",
       medium: "300x300>",
       thumb: "100x100#>" 
     }
       # default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
   
  # you can also explicitly define enum as:  enum access_level: [:user => 0, :website_admin => 1, :super_admin => 2}
  enum access_level: [:user, :website_admin, :super_admin]
  # after_initialize :set_default_access_level, :if => :new_record?
  has_many :authentications, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :searches

  has_secure_password
  validates :email, presence: true, uniqueness: true,
  format: {
    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
  }

  before_save :downcase_email

  # def set_default_access_level
  #   self.access_level ||= :user
  # end

  def self.create_with_auth_and_hash(authentication, auth_hash)
    # byebug
    user = User.create!(first_name: auth_hash["info"]["name"], email: auth_hash["extra"]["raw_info"]["email"],:password => auth_hash['uid'])
    
    # byebug
    user.authentications << (authentication)

    return user
  end
  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  def password_optional?
    true
  end

  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end
end
