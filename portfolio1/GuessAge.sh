#!/bin/bash 
#STUDENT ID 10466645  NAME: DENIL RAI 
#A guessing game script where users have to correctly try to guess the age which has been randomly generated. 
#Has two modes of play single and multiplayer.


random_Age=$(($RANDOM % 82 + 1)) #A variable called random_Age that stores an integer that is generated randomly. 
counter=1  #This is a counter variable which will be used to keep track of the player's guess attempts.
TwoCounter=1  #This is the second counter variable that will be used for keeping track of the second player's guess attempts in multiplayer mode.

#This prints a simple welcome message and tells what kind of game it is.
echo -e """ 
        WELCOME TO 'HOW OLD AM I ???'
        ****************************
    It's as simple as it sounds! Can you 
    guess my age? Let's have some fun. :)\n
    """

#This creates a prompt inside the select loop which presents players with the option of either single player mode or multiplayer mode.
PS3="Please choose a game mode. Enter (1) or (2): "

select opt in "Single player" "Multiplayer"; do  #Creates a menu with gameplay mode options that users can select.
    case $opt in #starts case statement.
        "Single player")  #Single player mode of the game. 
            
            read -p $'\n'"What is your name challenger? " name #Asks the player for his or her name.
            
            #This is an error handler that validates whether the input entered by the player has numbers and/or special characters. If input contains numbers or special characters, it will not be accepted.
            while true; do
                if ! [[ "$name" =~ ^[a-zA-Z]+$ ]]; then
                    read -p "Alphabet characters only! Please re-enter: " name #Prompts the player to re-type his name with only alphabets. 
                else
                    break
                fi
            done

            #prints a greeting message for the player
            echo -e "\nGreetings $name! I am the AI. I can be any age but can you guess how old I am right now?"
            
            for ((i=10; i>0; i--)) #Creates a loop that iterates 10 times and ech iteration will represent a guess attempt made by the player. So players will only get 10 attempts to correctly guess the age. 
            do 
                read -p $'\n'"You have $i attempts left. What's my age: " player_guess #Displays a prompt that shows the player how many attempts they have left and also to make a guess. 
                                                                                    #After each guess the number of remaining attempts will decrease.
                
                #This is an error handler that validates whether an input has only integers or not. If it contains alphabets and/or special characters, it will not be accepted.
                while true; do
                    if [[ ! "$player_guess" =~ ^[0-9]+$ ]]; then 
                        read -p "Please type an integer. Decimals, letters and special characters are not allowed! 
                        What's my age: " player_guess #prompts the player to re-enter an input using only integers.
                    else 
                        break
                    fi
                done

                #An if, then, else structure that checks if the player's input matches the randomly generated age. If player_guess is equal to random_Age, proceeds to print the messages.
                if [ "$player_guess" -eq "$random_Age" ]; then
                    echo -e "\nCongratulations! You correctly guessed my age. :D "
                    echo "You found out my age in $counter attempts."
                    
                    #This is a nested if, then, elif structure that prints different congratulatory messages. The counter variable that stores the players attempts is used to determine which message to print.
                    if [[ "$counter" -ge 1 ]] && [[ "$counter" -le 2 ]]; then
                        echo -e "\nYou're like Sherlock Holmes! "
                        break
                    elif [[ "$counter" -ge 3 ]] && [[ "$counter" -le 5 ]]; then 
                        echo -e "\nGreat job! Those were good guesses! "
                        break
                    elif [[ "$counter" -ge 6 ]] && [[ "$counter" -le 8 ]]; then
                        echo -e "\nNot bad. You're pretty good! "
                        break
                    elif [[ "$counter" -ge 9 ]] && [[ "$counter" -le 10 ]]; then
                        echo -e "\nLady luck smiled at you! You made it in the end. "
                        break
                
                    fi

                #Prints a message that tells the player they guessed the wrong age. This statement will be executed should the 'if condition' on line 56 returns false. 
                else 
                    echo -e "\nToo bad! Your guess was wrong. :( "
                    
                    #This is a nested if else structure that compares the wrong guess of the player and the correct age, then it prints appropriate messages depending on whether the player over-guessed or under-guessed.
                    if  [ "$player_guess" -gt "$random_Age" ]; then 
                        echo -e "I'm younger than that. \n"  #prints a hint message if the value of player_guess is greater than random_Age.
                    else 
                        echo -e "I'm older than that. \n"   #prints a hint message if the value of player_guess is lesser than random_Age.
                    fi
                
                fi

                #A if statement that prints a message if the counter variable is equal to the integer 10.
                if [[ "$counter" -eq 10 ]]; then
                    echo -e "\nHaha You lost! I am $random_Age years old!"
                    break
                fi

                counter=$(($counter+1)) #After each iteration, it increments the counter value by 1. 

            done #end of the for loop.
            break # stops the single player mode loop.
            ;;
        
        "Multiplayer") #Starts multiplayer mode 
            
            read -p $'\n'"What is player 1's name: " one  #Prompts for first players name.
            
            #Error handler. (Same as line 28)
            while true; do
                if ! [[ "$one" =~ ^[a-zA-Z]+$ ]]; then
                    read -p "Alphabet characters only! Please re-enter: " one
                else
                    break
                fi
            done
            
            read -p $'\n'"What is player 2's name: " two #prompts player two for their name.
            
            #Error handler (same as line 28, 105)
            while true; do
                if ! [[ "$two" =~ ^[a-zA-Z]+$ ]]; then
                    read -p "Alphabet characters only! Please re-enter: " two
                else
                    break
                fi
            done

            while true; do #Starts loop to iterate the number of attempts taken by player one.
                
                read -p $'\n'"Get ready $one! How old am I: " one_guess #Prompts player one to make a guess.
                
                #Error handler (same as line 45)
                while true; do
                    if [[ ! "$one_guess" =~ ^[0-9]+$ ]]; then 
                        read -p $'\n'"Only whole numbers alowed! 
                        How old am I: " one_guess
                    else 
                        break
                    fi
                done

                #If statement that compares the value of player ones guess with the random_Age value using equal to condition. if condition is true proceed to statement.
                if [ "$one_guess" -eq "$random_Age" ]; then
                    echo -e "\nCongratulations! You correctly guessed my age. :D" #prints congratulatory message for corectly guessing the age.
                    echo -e "It took you $counter attempts.\n" #prints message showing how many attempts it took player one.
                    break

                #If condition is false proceed to else statements.
                else 
                    echo -e "\nThat isn't my age!" #Prints a message 
                    #nested if else structure that compares the one_guess value with random_Age value using greater than condition. if condition is true proceed to statement.
                    if  [ "$one_guess" -gt "$random_Age" ]; then 
                        echo -e "I'm not that old. GO lower. \n" #prints a message if condition is true.
                    #if condition is false proceed to else statement.
                    else 
                        echo -e "I'm not that young. Go higher. \n" #prints a message if condition is false.
                    fi 
                fi
                counter=$(($counter+1)) #increments the the value of counter by 1 with each iteration.
            done #ends loop for player 1

            random_Age=$(($RANDOM % 82 + 1)) #Stores a new random age for player two to guess.
            while true; do #starts loop to iterate attempts made by player two.

                read -p $'\n'"Get ready $two! How old am I: " two_guess #prompts for player two to make a guess.
                
                #Error handler (same as line 45 and 129)
                while true; do
                    if [[ ! "$two_guess" =~ ^[0-9]+$ ]]; then 
                        read -p $'\n'"Only whole numbers alowed! 
                        How old am I: " two_guess
                    else 
                        break
                    fi
                done

                #if else strcture that compares two_guess value with random_Age using equal to condition. if condition is true proceed to statements.
                if [ "$two_guess" -eq "$random_Age" ]; then
                    echo -e "\nCongratulations! You correctly guessed my age. :D" #prints a congratulatory message.
                    echo -e "It took you $TwoCounter attempts.\n" #prints a message showing how many attempts it took player two.
                    break
                #if condition is false proceed to else statement.
                else 
                    echo -e "\nThat isn't my age!" #prints a message.
                    #nested if else structure that compares two_guess with random_Age using greater than condition. if true proceed to statement.
                    if  [ "$two_guess" -gt "$random_Age" ]; then 
                        echo -e "I'm not that old. GO lower. \n" #prints this message if condition is true.
                    else 
                        echo -e "I'm not that young. Go higher. \n" #prints this message if condition is false.
                    fi
                fi
                TwoCounter=$(($TwoCounter+1)) #increments value of TwoCounter by 1 after each iteration.
            
            done #ends loop for player 2

            #simple if esle structure used to decide which player is the the winner. counter is compared with TwoCounter using lesser than condition. 
            if [ "$counter" -lt "$TwoCounter" ]; then
                echo "The winner is $one! Congratulations!" #prints this message if the condition is true.
            else
                echo "The winner is $two! Congratulations!" #prints this message if the condition is false.
            fi
            
            break #ends multiplayer mode.
            ;;
        
        *) echo "Invalid choice" ;; #Default message that is printed if player does not make a valid choice in the options menu. 
    esac #ends case statement.
done #ends select loop.

 
 





