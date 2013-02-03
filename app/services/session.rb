class Session
	def self.authenticate(options={})
		user = User.authenticate(options[:login], options[:password])
	end
end