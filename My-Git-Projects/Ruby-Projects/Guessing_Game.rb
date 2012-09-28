#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Programmers: Mac Watson, Brian Rashty
# Program Language: Ruby using v1.9.2 or v1.8.7
# Program Purpose: generates a random number and prompts the user to guess it
# Date: 10/19/2011, Fall 2011, SUNY Fredonia
#
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Purpose: class level object that will control the game spacing
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class SCREENCLEANER
 
  #-------------------------------------------------------------------------------
  # Class Data Set:
  #-------------------------------------------------------------------------------
 
  #this class does not store any data
 
  #-------------------------------------------------------------------------------
  # Class Behavior Method Set:
  #-------------------------------------------------------------------------------
 
  #this method uses the newline object using multiplication of two objects
  def cls         	# cls clears the screen using new line \n
	# local vars; even though there is an index being use, it must be called on
	#         	when it is needed. This is how ruby sets up and uses memory
	#         	only when needed.
	
	# look below, the index gets it's range in it's intended use	
	for index in 0..24
  	puts ("\n")
	end
  end
 
  # clears half the amount of times
  def mid_cls
 for index in 0..10
  	puts ("\n")
	end
  end
 
  #this will make the program idle until the enter key is pressed
  def pause_program
	STDIN.gets
  end
 
  #def play_or_not(some_answer)
   # @answer = some_answer
	#@answer.chop!
  #end
 
 
end
class GREETING_CLASS
  #-------------------------------------------------------------------------------
  # Class Data Set:
  #-------------------------------------------------------------------------------
 
  # no data set required for this class
 
  #-------------------------------------------------------------------------------
  # Class Behavior Method Set:
  #-------------------------------------------------------------------------------
 
  # This method greets the player
  def hello
	puts ("Welcome to the Number Game!\n")
  end
 
  # askes the player to guess random number
  def guess_number
	puts ("Enter your guess: ")
  end
 
  # Method asks the user to play again
  def play
	puts ("Would you like to play? (y/n)")
  end
  # Method asks the user to exit
  def exit
	puts ("Would you like to continue? (y/n)")
  end
 
  # Displays the games directions
  def instructions
	puts("\tThe Rules: \n")
	print("\tPlaying this game is easy. A random number is generated a\n")
	print("\tand the player is asked to guess what it is. If the players guess \n")
	print("\tis within 10% of the number than the player is correct. The player\n")
	print("\tmust get five numbers correct in a row to win. You may exit whenever.\n")
	print("\tGood Luck!\n\n")
	puts ("Press Enter to continue.")
  end
  
  # displays a random message to the player
  def encouragement
	
		encourage = rand(5)
		 case encourage
		when 0
			puts "You can do it! \n"
		when 1
			puts "I beleive in you! \n"
		when 2
			puts "Dont give up! \n"
		when 3
			puts "Keep on guessing! \n"
		when 4
			puts "The force is with you! \n"
		when 5
			puts "Youre almost there! \n"
		else
			puts "An Error has occured! \n"
			
		end
  end

 
  #prompt the player to play again
  def bye
 print "Thanks for playing!"
  end
end

# This class is used to create a random range for a random number to be determined
# the player then tries to guess the random number
class NUMBER_CLASS
	
	# creates a random number for the lower limit of the range
  def create_lower_limit
	lower_limit = rand(99)
	return lower_limit

  end
	
	# creates a random number for the lower limit of the range
	# and then adds the lower limit to this limit so no matter what
	# the limit created in this method is higher than the limit created in create_lower_limit
  def create_upper_limit(some_lower_limit)
 upper_limit = some_lower_limit + rand(999)
 return upper_limit

  end
 
	# determines an average number between the two random numbers to be the 
	# targetted number for the player to guess
  def average(some_lower_number, some_upper_number)
 avg = ((some_lower_number + some_upper_number) / 2)
 return avg
  end
 
 # This method determines the limits for the player to win
 # this means the player has to be 10% within the range of the targetted number
 # it subtracts the upper limit from the lower limit and adds one to it to find 
 # the distance and add one to it so the actual number will be displayed
 # then to find the ten percent and 
  def guess_limits(lower_limit, upper_limit)
 distance_from_target = (upper_limit - lower_limit + 1) / 10

 return distance_from_target
  end
 
  def check_guess(ten_percent, target_number, player_guess)
 
 lower_range = target_number.to_i - ten_percent.to_i
 upper_range = target_number.to_i  + ten_percent.to_i
 
 if (player_guess.to_i  == target_number.to_i )
  return 5
 elsif ((player_guess.to_i  >= lower_range.to_i ) and (player_guess.to_i  <= upper_range.to_i ))
	return 1
  else
  return 0
 end
  end
end



class POINTS_CLASS

       def check(score)
	   
	      if (score>=5)
		  puts "You Won!"
			print ("\a\a\a\a\a")
	      new_number=1
		  else
			puts "You have " + score.to_s + " point(s)! Press Enter to continue"
	      end
       end
end

#-------------------------------------------
# MAIN STARTS HERE

# initilize instance classes
Console = SCREENCLEANER.new
Points=POINTS_CLASS.new
Number=NUMBER_CLASS.new
Greeting=GREETING_CLASS.new

# say hello
Greeting.hello

# prompt to play and gets the players input (y/n)
Greeting.play
play=(STDIN.gets).chop!

Console.cls

# displays instructions
Greeting.instructions
Console.pause_program
Console.cls

# initialize our variables
# exit is used to exit gameplay when it is set to true
# total_points determine if the player wins or not
# new number makes it so the same random number is guessed until the player is within the range
exit=false
total_points = 0
new_number=1

# where gameplay begins
while (exit==false)
	
	# if the player decides to play
	if ((play=="Y") || (play=="y"))
		
		# starts the game off by finding a new random number within a random range
		if (new_number==1)
		
		# sets the new number varaible to 0 so the code in this if statement does not go off until the player finds the number
		new_number=0
		
		# finds lower number used for the range
		lower_number = Number.create_lower_limit
 
		
		# finds upper number used for the range
		upper_number = Number.create_upper_limit(lower_number)
 
		
		# finds the average of the random range above
		mid_point = Number.average(lower_number, upper_number)
 #-------------------------------
 # DELETE THIS
		#puts "midpoint"
		#puts mid_point
# -------------------------------
		end	# ends if 


	
	puts "Im thinking of a number between " + lower_number.to_s + " and " + upper_number.to_s
	
	# asks to guess the number and gets the players input
	Greeting.guess_number
	number_guess =(STDIN.gets).chop!
#------------------------------------------------------------------------------------
 
	# number.guess_limits finds the acceptable range for the guess
	# number.check_guess takes number.guess_limits as the acceptable range +- the average of the random average
	# it also passes the number the player is trying to guess (mid_point) and the players guess
	# This entire function call determines if the players input is within the range and if it is the players points increase by 1
	# and the points increase by 5 if they select the number
	# we put the function call this way to have less overhead
	total_points = total_points + Number.check_guess(Number.guess_limits(lower_number, upper_number), mid_point, number_guess).to_i
 
	# determines the player wins or shows how many points they have
	Points.check(total_points)
	
	Console.pause_program
	Console.cls
	
	Greeting.encouragement
	
	
	
	# prompts the player to exit and gets their input
	Greeting.exit
	play=(STDIN.gets).chop!
	

	Console.cls
 
 
 
 #---------------------------------------------------------------------------
  elsif ((play=="N")||(play=="n"))
  
	exit=true
	print("\a\a")
	Greeting.bye
  

 else
	print("\a")
	puts "You entered an invalid choice!"
	Greeting.play
	play=(STDIN.gets).chop!
 end
end
