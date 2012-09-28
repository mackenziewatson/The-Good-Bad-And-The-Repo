#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Programmers: Mac Watson, Brian Rashty
# Program Language: Ruby using v1.9.2 or v1.8.7
# Program Purpose: Demonstrates "programmer created" class and programming language
#                  "provided" class object uasage.
# Date: 8/30/2011, Fall 2011, SUNY Fredonia
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
  def cls             # cls clears the screen using new line \n
    # local vars; even though there is an index being use, it must be called on
    #             when it is needed. This is how ruby sets up and uses memory 
    #             only when needed.
    
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

class GREETING

  #-------------------------------------------------------------------------------
  # Class Data Set:
  #-------------------------------------------------------------------------------
  
  # no data set required for this class
  
  #-------------------------------------------------------------------------------
  # Class Behavior Method Set:
  #-------------------------------------------------------------------------------
  
  # This method greets the player
  def greet_the_player
    puts ("Welcome to the Wheel Of Fortune!\n")
  end
  
  # Method to prompt the player for a guess
  def prompt_for_guess
    puts ("1. Enter a vowel.")
	puts ("2. Enter a consonant.")
	puts ("3. Guess the entire word.")
	puts ("(Enter your letter choice now. If you enter more than a letter than its your own fault.)")
  end
  
  # askes the player if they would like to guess the entire word
  def guess_hidden_word
    puts ("Enter your guess: ")
  end
  
  # Method asks the user to guess again
  def guess_again
    puts ("Would you like to enter another guess? (y/n)")
  end
  
  # Displays the games directions
  def directions
    puts("\tThe Rules: \n")
    print("\tPlaying this game is very simple. The game will first display a\n")
    print("\trandomly selected word replaced with underscores and a hint to\n")
    print("\twhat the word is. The player (you) will then be prompted to enter\n")
    print("\teither a vowel or a consonant. The game will then print out anoter\n")
    print("\tscreen with any spaces filled in the hidden word if you entered\n")
    print("\ta correct guess. The player will than have the option to enter\n")
    print("\tthe entire word or keep guessing single letters. WARNING if you\n")
    print("\ttry to guess the hidden word and turnout to be incorrect than\n")
    print("\tyou lose the game. The wheel is spun for every guess. When\n")
    print("\ta player enters a vowel 250 points is deducted, but if a \n")
    print("\tplayer enters a correct consonant they win the point for the\n")
    print("\tround, Good Luck!\n\n")
    puts ("Press Enter to continue.")
  end
  
  #prompt the player to play again
  def play_again
	print "Would you like to play again? (y/n)"
  end
end





# This is the main wheel of fortune game logic
#---------------------------------
# Methods Include: 
#	set_master_word
#	set_master_hint
#	set_masked_word
#	display_master_word
#	display_masked_word
#	display_master_hint
#	determine_if_vowel
# 	determine_if_consonant
#	guess_entire_word
#------------------------------------------
class WORD

  #-------------------------------------------------------------------------------
  # Class Data Set:
  #-------------------------------------------------------------------------------
  
  attr_accessor :master_word, :masked_word, :word_array, :hint_array, :player_points
  
  #-------------------------------------------------------------------------------
  # Class Behavior Method Set:
  #-------------------------------------------------------------------------------

  # This method selects a word in a library of predefined words for use in  the game
  # SELECTS A RANDOM WORD
  def set_master_word(some_word, some_array)
	@master_word = some_word	# set up an instance variable for a random word
	@word_array = some_array	# instance variable for the array of words
	
	# Generate and return a random number between 0 and 19 because there are 20 answers in the array @word_array
	#important this is an instance variable so whatever random number is selected can correspond with other methods
	@randomNo = rand(19)
  
	@master_word = @word_array[@randomNo]	# assign a random word from the word_array to @master_word

  end
  
  
  
  # Uses an array and the random number generated in the select_word method to extract the hint that
  # cooresponds with the word in word_array
  def set_master_hint(some_hint_array)
	@hint_array = some_hint_array	# set up instance variable for hint array
	
	# This statement assigns the random number previously found and assigns it into a master_hint variable
	@master_hint = @hint_array[@randomNo]
	
  end

  # This method takes the random word found in select_word and replaces each letter with _
  # MASKS THE RANDOM WORD
  def set_masked_word(master_word)
  
  counter = 0 # This counter is used for the each loop Used Locally!
  
    @randomWordArray = @master_word.scan(/./)   # split the random word so each letter is in its own spot in an array
    # .scan is slightly faster than .split, but both do the same thing
    
    @masterWordArray = @master_word.scan(/./)   # masterWordArray holds the split up word but in an array with no _
    
    # The .each method is tailor made for arrays. When an array is made and the .each method is used the each loop 
    # automatically walks through each item in the array performing commands between cycles
    # Every time the loop passes through the array the current item is assigned the letter variable
    # and then the current letter is replaced by an underscore
    @randomWordArray.each do |letter|
      @randomWordArray[counter] = "_ " #ex: prints "_ _ _ _ _ " assigns _ in place of a letter
      #print randomWordArray
      counter += 1    # increments the counter to move to the next spot in the array
    end	# end each loop
    
    # This statement takes @random_word that we split up and joins the array back into one string
    @masked_word = @randomWordArray.join("")

	
  end
  
  # display master word
  def display_master_word
	puts "The unknown word is " + @master_word
  end
  
  # displays the master hint selected in the hint_array in the select_hint method
  def display_master_hint
    print ("\tHINT: #{@master_hint}\n\n")
  end
  
  # displays the masked word that was replaced with _ based on the master word
  def display_masked_word
    print ("\tHIDDEN WORD: #{@randomWordArray.join("")}\n\n") # ex: prints the random word
  end
  
  
  
  
  
  # This method is responsible for determining if a player entered a vowel. 
  # if a vowel was entered a pattern will execute and the following steps will be taken
  def determine_if_vowel(some_guess, some_points)
	@player_guess = some_guess		# player_guess is the players guess coming from the main
    @player_points = some_points	# set up instance variable for the players current points
	
	
     #The if statement is used because only vowels are useful data here
	 # if the user has less than 250 points than the method boots the player
	 # out and tells the player they cannot buy a vowel
    if @player_points.to_i < 250 then
	  print "Insufficient funds, try a consonant. Press Enter to continue"
	  Console_Screen.pause_program
    else
		# deduct 250 points
      @player_points = @player_points.to_i - 250
    
	
	# if the players guess is a vowel the following code will execute
	if @player_guess =~ /A|E|I|O|U/
    counter = 0     # a counter is initialized for use in the .each loop
      @masterWordArray.each do |letter|   # this is where the .each loop begins. it uses the @masterWordArray as its object
      #                                     # and this array is used in the .each loop to process the data and sort out which 
      #                                     # letters can be matched with the master word and which ones wont
      
        if letter == @player_guess then               # This if statement is used to compare the current item being processed in the loop
          @randomWordArray[counter] = @player_guess   # and the players guess

        end  # end if statement                       # If the if statement is true than the players guess is assigned to the
        #                                             # @randomWordArray which is masked and replaces the _ that cooressponds to the master word
        
        counter +=1   # increments the counter
      end # ends the each loop
    
	else	# Error handling
	print "Please try again that was not a vowel. Press Enter to continue."
	Console_Screen.pause_program
	end		# end 2nd if

	end		# end 1st if
	Console_Screen.cls
    #print @masterWordArray
    #print("\n\n")
    #print @randomWordArray

	return @player_points	# returns the points accumulated for the round and returns the value to the calling statement
  end
  
  
  
  
  # This method is EXACTLY the same as the determine_if_vowel method, except the =~ in the first if statement is changed to !~ (not)
  def determine_if_consonant(some_guess, some_points, session_points)
	@player_guess = some_guess		# guess is the players guess coming from the main
    @player_points = some_points		# set up instance for the players current points
	@points_for_round = session_points	# instance variable for whatever points the player spun for on the wheel

    # The if statement is used because only consonants are useful data here
    
	# if the player_guess is not equal to a vowel the following code will execute
	if @player_guess !~ /A|E|I|O|U/
    counter = 0     # a counter is initialized for use in the .each loop
      @masterWordArray.each do |letter|   # this is where the .each loop begins. it uses the @masterWordArray as its object
      #                                     # and this array is used in the .each loop to process the data and sort out which 
      #                                     # letters can be matched with the master word and which ones wont
      
        if letter == @player_guess then               # This if statement is used to compare the current item being processed in the loop
          @randomWordArray[counter] = @player_guess   # and the players guess
          @player_points = @player_points.to_i + @points_for_round.to_i		# add the points the player spun for to the current total
          print @player_points

        end  # end if statement                       # If the if statement is true than the players guess is assigned to the
        #                                             # @randomWordArray which is masked and replaces the _ that cooressponds to the master word
        
        counter +=1   # increments the counter
      end # ends the each loop
    
	else
		print "Please try again you did not enter a consonant. Press Enter to continue."
		Console_Screen.pause_program
	end	# end if statement

	Console_Screen.cls
    #print @masterWordArray
    #print("\n\n")
    #print @randomWordArray
  
  return @player_points		# returns the players new amount of points to the calling statement
  
  end
  
  
  
  
  # This method allows the player to guess the entire word. If they choose to do so they may enter the entire word
  # If the word matches the master_word than they win the game
  def guess_entire_word
  
  Welcoming.guess_hidden_word # shows a message asking if they would like to guess the entire word
  
  # Gets the players input and formats it (local varariable)

  
  # If the player slelected y than they are then prompted to enter the entire word. Their guess is then formatted

  # Gets the players input and formats it (local varariable)
    player_answer = STDIN.gets
    player_answer.chop!
    player_answer = player_answer.upcase
    @master_word.chop!		# removes extra character on the master word
    # After the player inputs their guess, the guess is run through the next if statement. 
    # This if tests if the players answer is equal to the master_word
    # if the player is correct than they win the game. if not they get an incorrect message
      if player_answer == @master_word
        puts("#{@master_word} is correct! Press Enter to continue.\n")
        
        $player_won_lost = 1          # This variable will be used in the main program to determine what the player will do
      else
        puts("Sorry thats incorrect. Press Enter to continue.\n") 
        $player_won_lost = 2       # this variable is used in the main program and will let the player know they lost
      end
	  
	Console_Screen.pause_program
	Console_Screen.cls
	  
  
  end
  
  
end








# This class is for the points system and how they interact with the main game
#---------------------------------------
# Methods include:
#	set_points
#	display_points
#	spin_wheel
#---------------------------------------
class POINTS

	# Sets the total points at the beginning of a game 
	def set_points(some_points)
    @player_points = some_points
	#some_points = 1000
    #@player_points = 1000
	return @player_points
	#return some_points
  end

  # displays the total points whenever its called
  def display_points(some_points)
    puts ("Total Points: #{@player_points}")
  end
  
  
  
  
  # Generates a random number based off an array and then pulls out the point amount based off that
  # number in the array. It then has an if statement that catches if the BANKRUPT value is rolled
  # If bankrupt is rolled than the player loses all their points, a string is outputed and 
  # the player is prompted to roll again
  def spin_wheel(some_point_array)
    
	@point_array = some_point_array		# instance variable for the points array from the main
	
    
    puts("Press Enter to spin the wheel of fortune!")
    Console_Screen.pause_program
    
      @random_number = rand(19)	# generates a random number for use with the point_array
      
      if @random_number == @point_array[19]             # if statement for rolling bankrupt
        puts("BANKRUPT! You lose all your money, Spin Again.")
        @player_points = 0    # assigns the player 0 points
        
        while @random_number == @point_array[19]	# while loop to make sure the next spin is not bankrupt
        
        @random_number = rand(19)
        
        end
        
      else
        
        # other wise the points are set into a points_for_round variable and displayed to the player
        @points_for_round = @point_array[@random_number]
        #Console_Screen.cls
        puts ("Wheel Results: #{@points_for_round}")
      end
	  
	  return @points_for_round		# return the total points for the round to be played for back to the calling statement
  end
  
end

#-------------------------------------------------------
# MAIN PROGRAM SECTION
#-------------------------------------------------------

Welcoming = GREETING.new    # Declare and set up an instance of a greeting instance based on the GREETING class
Console_Screen = SCREENCLEANER.new  # Delcare and set up an instance for the SCREENCLEANER class
Game = WORD.new	# Declare and set up and instance of an instance of the WORD class
Score = POINTS.new	# Declare a new instance of the POINTS class

$player_won_lost = 0		# global variable set to zero, determines when the player won or lost when not zero

$player_answer = (" ")        # global variable declared at runtime to determine when the loop should exit
master_word = (" ")			# holds unmasked word
game_points = 0					# variable for the points for the games score


# The following code opens up a file and reads in the contents to an array.
# Then it splits the file array into the word_array and the hint_array
#--------------------------------
#puts "Enter word file path"
#word_file= STDIN.gets
#word_file.chomp!
#puts "Enter hint file path"
#hint_file= STDIN.gets
#hint_file.chomp!
#word_array = File.readlines(word_file)
#hint_array = File.readlines(hint_file)

def chunk_array(array, pieces=2)
  len = array.length;
  mid = (len/pieces)
  chunks = []
  start = 0
  1.upto(pieces) do |i|
    last = start+mid
    last = last-1 unless len%pieces >= i
    chunks << array[start..last] || []
    start = last+1
  end
  chunks
end
puts "Enter file path"
file= STDIN.gets
file.chomp!
file_array = File.readlines(file)
  word_array , hint_array =chunk_array(file_array,2)

#---------------------------------
master_word = word_array[rand(word_array.size)].chomp


# used to determine what type of score the player will get to try for
point_wheel = [100,150,200,250,300,350,400,450,500,550,600,	# array with numbers 100-1000 and bankrupt
                    650,700,750,800,850,900,950,1000,"BANKRUPT"]





Welcoming.greet_the_player # greets the player

print ("Would you like to play the game? (y/n)\n")  # asks if the player would like to start the game
    
  $player_answer = STDIN.gets      # gets the players input and stores it in player_answer
  $player_answer.chop!     # removes the last character from the players input
  $player_answer = $player_answer.downcase  # Makes the players input lowercase so if N was entered it would still be valid
  
  Console_Screen.cls    # Clears the screen (scrolls 25 times)
  
  #START THE MAIN PROGRAM
  
  
	if $player_answer == "n"   # if the player selected not to play in the previous section than the game terminates
    
    # Invites player to play again
    puts "To bad, this game is fun! Play again soon!"
    
	else
  
  
    
      Welcoming.directions  #display the directions
      Console_Screen.pause_program
      Console_Screen.cls
	  
	  Game.set_master_word(master_word, word_array)	# calls the method and passes the args for the master word and word array
	  Game.set_master_hint(hint_array)				# calls the method and passes the hint array to it
	  Game.set_masked_word(master_word)				# calls the method and passes the master word to it
	  game_points = Score.set_points(game_points)	# calls the set_points method and passes the args game_points and returns a value to be stored in game_points
	  
	  #Score.display_points(game_points)
	  
	  # while the players answer is yes, keep playing
	  while $player_answer == 'y'
		
		# if the player won this statement goes off
		if $player_won_lost == 1
			puts "You Won!"
			
		# if the player lost this statement goes off
		elsif $player_won_lost == 2
			puts "Way to go you lost the Game!"
				
		else 
		
			Game.display_master_hint  # displays the master hint
			Game.display_masked_word    # displays the masked word with the correct letters the player has selected
		
			round_points = Score.spin_wheel(point_wheel)		# spins the wheel of fortune to get point amount for round and stores the result in round_points
			
			Console_Screen.cls
			print "Wheel of Fortune Results: #{round_points}\n\n\n"
			print "Player Points: #{game_points}\n\n\n"
			
			Game.display_master_hint  # displays the master hint
			Game.display_masked_word    # displays the masked word with the correct letters the player has selected
			
			Welcoming.prompt_for_guess	# prompts the player for a guess either 1 2 or 3
			guess_choice = STDIN.gets
			guess_choice.chop!

			
			case guess_choice
			
				when ("1")
					
				
					print "Enter a Vowel: "
					current_guess = STDIN.gets	# stores the guess in current_guess
					current_guess.chop!			# chops off the extra character
					current_guess = current_guess.upcase		# converts the guess to uppercase
					
					#already_guessed = already_guessed.to_s + " " + current_guess.to_s

					#print already_guessed
					
					game_points = Game.determine_if_vowel(current_guess, game_points)	
							# determines if the guess is vowel, places any correct vowels in the masked word and returns the new gamepoints
					game_points = Score.set_points(game_points)						# Reinitialize the points the player has in for POINTS class use
					
					Score.display_points(game_points)	# displays the players current points
				when "2"
					
				
					print "Enter a Consonant: "
					current_guess = STDIN.gets	# stores the guess in current_guess
					current_guess.chop!			# chops off the extra character
					current_guess = current_guess.upcase		# converts the guess to uppercase
					
					#already_guessed = already_guessed.to_s + " " + current_guess.to_s

					#print already_guessed
					
					game_points = Game.determine_if_consonant(current_guess, game_points, round_points)
					game_points = Score.set_points(game_points)						# Reinitialize the points the player has in for POINTS class use
					print game_points
				when "3"
					Console_Screen.cls
					Game.guess_entire_word  # allows the player to guess the entire word
				else
				
					puts "\tWrong type of input please try again"
				Console_Screen.mid_cls
			end	# end case
			
		
			
			
	    end 	# end if
	  
	  # This if statement goes off if the player won or lost
	  if $player_won_lost != 0
		
		Welcoming.play_again
		
		# gets the players input for if they wish to play again
		$player_answer = STDIN.gets
		$player_answer.chop!
		$player_answer = $player_answer.downcase
		
		if $player_answer == 'n'      # if n is selected than it is returned to the main program and the game terminates
			print ("Come back and play again soon! Press Enter to continue.")
			Console_Screen.pause_program
		else 
			# If the player plays again , the master word, master hint and masked word are newly selected and reinitialized
			$player_won_lost = 0
			Game.set_master_word(master_word, word_array)
			Game.set_master_hint(hint_array)
			Game.set_masked_word(master_word)
		end	# end 2nd if
	   end	# end 1st if
	  
	  end #while loop
	  

	  
	  
	end
	


