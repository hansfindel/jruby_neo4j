class User < Neo4j::Rails::Model
  property :username, :type => String
  property :email, :type => String
  property :password_hash, :type => String
  property :password_salt, :type => String
  property :pending_account, :type => String

  # add an exact lucene index on the email property
  property :email, :index => :exact
  property :username, :index => :exact

  def to_param
    username.parameterize
  end

  before_save  :encrypt_password
  #after_create :set_pending

  attr_accessor :password
  attr_accessible :email, :username, :password, :password_confirmation, :pending_account

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  username_regex = /\A[\w+\-.]/i  

  validates :email, :presence => true, :format   => { :with => email_regex }
  validates :email, :uniqueness => true #, :unless => :pending_account?
  validates :username, :presence => true, :format   => { :with => username_regex }
  validates :username, :uniqueness => true #, :unless => :pending_account?
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


end
