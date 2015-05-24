module UsersHelper

	def name(user)
		case user
			when user
				user.name.partition(' ').first
			when @user
				@user.name.partition(' ').first
		end
	end

	def age(user)
		case user
			when user
				age = Date.today.year - user.date_of_birth.year 
	        	age -= 1 if Date.today < user.date_of_birth + age.years
	        	return age
			when @user
				age = Date.today.year - @user.date_of_birth.year 
	        	age -= 1 if Date.today < @user.date_of_birth + age.years
	        	return age
		end
	end

	def location(user)
		case user
			when user
				user.location.partition(',').first
			when @user
				@user.location.partition(',').first
		end
	end


end