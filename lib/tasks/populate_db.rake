task :populate_db => :environment do

	password = "1234"
	100.times do |i|
		name = "user_#{i}"
		email = "email_#{i}@mail.cl"
		user = User.new(:username => name, :email => email, :password => password)
		if user.save
			puts "user #{i} saved"
		end
	end

end