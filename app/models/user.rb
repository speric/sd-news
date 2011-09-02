class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field           = :name
    c.validate_login_field  = false
    c.validate_email_field  = false    
  end
  
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true, :length => { :minimum => 4 }
  
  def admin?
		self.admin
	end
end