class User < Neo4j::Rails::Model
  #property :username, :type => String
  #property :email, :type => String
  property :password_hash, :type => String
  property :password_salt, :type => String
  property :pending_account, :type => String

  # add an exact lucene index on the email property
  property :email, :index => :exact, :unique => true
  property :username, :index => :exact, :unique => true

  def to_param
    username.parameterize
  end

  before_save  :encrypt_password
  #after_create :set_pending

  attr_accessor :password, :login
  attr_accessible :email, :username, :password, :login, :pending_account

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  username_regex = /\A[\w+\-.]/i  

  validates :email, :presence => true, :format   => { :with => email_regex }
  validates :email, :uniqueness => true #, :unless => :pending_account?
  validates :username, :presence => true, :format   => { :with => username_regex }
  validates :username, :uniqueness => true #, :unless => :pending_account?
  validates :password, :presence   => true, :on => :create
  validates :password, :length     => { :within => 4..42 }, :on => :create
  #accepts_nested_attributes_for :avatar, :allow_destroy => true


  def pending_account?
  	pending_account
  end
  def confirm_user
  	self.pending_account = Time.now.strftime("%H:%M %d/%m/%y").to_s unless pending_account?
  end
  def confirm_user!
  	confirm_user
  	save 
  end
  def set_pending
  	pending_account = nil
  end
  def encrypt_password
    #if old_password.present? 
    #  if self.password_hash != BCrypt::Engine.hash_secret(old_password, self.password_salt)        
    #    return false
    #  end
    #end
	if password.present?
		#@old_salt = self.password_salt
		self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end
  end
  def self.find_login(thing)
 		if thing && thing.include?("@")
 			user=User.where("email like ?",thing.downcase).first
 		elsif thing
 			user=User.find_by_username(thing)
 		end
 		user
 	end
  def self.authenticate(login, password)
 		user = User.find_login(login)
 		
 		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
 			return user
 		elsif user # this is for users who created or want to login from a smartphone -> starts with capital 
 			pass = password.capitalize
 			pass2 = password[0,1].downcase.to_s + password[1, password.length].to_s
 			if user.password_hash == BCrypt::Engine.hash_secret(pass, user.password_salt) || user.password_hash == BCrypt::Engine.hash_secret(pass2, user.password_salt)
 				return user
 			else
 				return nil
 			end
 		else
 			nil
 		end
 	end

end
