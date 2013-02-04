task :populate_db => :environment do
	User.destroy_all
	Article.destroy_all
	Rate.destroy_all
	Write.destroy_all

	password = "1234"
	name = "writer"
	email = "writer@mail.cl"
	user = User.new(:username => name, :email => email, :password => password)
	if user.save
		puts "user #{user.username} saved"
	end
	name = "writer2"
	email = "writer2@mail.cl"
	user2 = User.new(:username => name, :email => email, :password => password)
	if user.save
		puts "user #{user.username} saved"
	end
	
	10.times do |i|
		article = Article.create(title: "h1_#{i}", content: "holo")
		user.outgoing(:writes) << article
		user.save
	end
	10.times do |i|
		article = Article.create(title: "w1_#{i}", content: "wololoh")
		user2.outgoing(:writes) << article
		user2.save
	end
	first_article = Article.find_by_title("h1_1")

	counter1 = 0
	counter2 = 0
	200.times do |i|
		name = "user_#{i+1}"
		email = "email_#{i+1}@mail.cl"
		user = User.new(:username => name, :email => email, :password => password)
		if user.save
			puts "user #{i} saved"
			if i % 3 == 0
				#reads some of the articles of writer
				a = Article.find_by_title("h1_#{counter1}")
				rate_params = {:grade => '#{(counter1.to_i * 3 % 5) + 5}', :comment => "c#{i}"}
				@role = user.outgoing(:rates) << a 
				#@role.grade = rate_params[:grade]
				#@role.comment = rate_params[:comment]
				#@role.save				
				#@role = user.rates_rels.connect(a, rate_params)
			    #@role.save
				counter1 = (1 + counter1.to_i) % 10
			end
			if i % 7 == 0
				#reads some of the articles of writer2
				a = Article.find_by_title("w1_#{counter2}")
				rate_params = {:grade => '#{(counter2.to_i * 3 % 7) + 2}', :comment => "cw#{i}"}
				# user.outgoing(:rates) << 
				@role = user.outgoing(:rates) << a 
				#@role.grade = rate_params[:grade]
				#@role.comment = rate_params[:comment]
				#@role.save				
				#@role = user.rates_rels.connect(a, rate_params)
			    #@role.save
				counter2 = (counter2 + 1) % 10
			end
			if i % 3 != 0 and i % 7 != 0 
				@role = user.outgoing(:rates) << first_article 
			end
			user.save
		end
	end

end