#The Controller

class Patents::CLI

  def call
    find_a_patent
  end

  #Ask the user for a patent number,
  def find_a_patent
    input = ""
    number = ""
    until input == "exit" do

      puts "Please enter a patent number: (to exit enter 'exit')"
      #Get the user input of a patent number and strip it
      input = gets.strip

      #Check it is a valid number
      if input.to_i.between?(100000, 99999999)

      #Take that number, create a patent instantiation and return a patent title
       puts "Here's that patent!"
       #"Patent number #{input} is entitled: " Scraper.new(number).title
       menu
      end #End of if input statement
    end #End of until loop
  end #End of find_a_patent

  def menu
     puts "What information would you like about this patent? (Please enter a number)"
     puts "1. Inventor(s) , 2. Application number, 3. Publication Date, 4. Filing date, 5. Assignee, 6. Primary Class, 7. Exit, 8. Enter a New Patent number"

      number = gets.strip
        while !number.to_i.between?(1, 8)
          puts "Please enter a number between 1 and 9:"
          number = gets.strip
        end

        #Find the thing they want using Scraper class
        if number == "1"
          puts "Inventors: "
          elsif number == "2"
            puts "Application number: "
          elsif number == "3"
            puts "Publication Date: "
          elsif number== "4"
            puts "Filing date: "
          elsif number == "5"
            puts "Assignee: "
          elsif number == "6"
            puts "Primary Class: "
          elsif number == "7" || number == "exit"
            input = "exit"
        end

  end

end #End of class
