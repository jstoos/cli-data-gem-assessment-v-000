#The Controller

class Patents::CLI

  @@attributes = ["Inventor", "Application Number", "Publication Date", "Filing Date", "Assignee", "Primary Class"
]

  def call
    find_a_patent
  end

  #Ask the user for a patent number
  def find_a_patent
    input = ""
    number = ""
    until input == "exit" do

      puts "Please enter a patent number: (to exit enter 'exit')"
      #Get the user input of a patent number and strip it
      input = gets.strip

      #Check it is a valid number
      if valid_number?(input)

      #Take that number, create a patent instantiation and return a patent title
        puts "Patent number #{input} is entitled:"
       #puts "Patent number #{input} is entitled: #{Patents::Patent.new(number).title}"


       #Offer the user the chance to get information on that patent
       menu
      end #End of if input statement
    end #End of until loop
  end #End of find_a_patent

  def valid_number?(number)
    number.to_i.between?(100000, 99999999)
  end

  def menu
    puts "What information would you like about this patent? (Please enter a number)"
    counter = 0
    @@attributes.each do |attribute|
      counter +=1
      puts "#{counter}. #{attribute}"
    end
      puts "#{@@attributes.size+1}. Enter a New Patent number or exit"

    #  puts "What information would you like about this patent? (Please enter a number)"
    #  puts "1. Inventor(s)"
    #  puts "2. Application number"
    #  puts "3. Publication Date"
    #  puts "4. Filing date"
    #  puts "5. Assignee"
    #  puts "6. Primary Class"
    #  puts "7. Enter a New Patent number or exit"

      number = gets.strip
        while !number.to_i.between?(1, (@@attributes.size + 1))
          puts "Please enter a number between 1 and 7:"
          number = gets.strip
        end

        #Find the thing they want using scraper class (Patent)
      puts "#{@@attributes[number.to_i-1]}: "
      if number.to_i.between?(1, (@@attributes.size))
        more_information?
      end
        # if number == "1"
        #   puts "Inventors: "
        #     more_information?
        #   elsif number == "2"
        #     puts "Application number: "
        #     more_information?
        #   elsif number == "3"
        #     puts "Publication Date: "
        #     more_information?
        #   elsif number== "4"
        #     puts "Filing date: "
        #     more_information?
        #   elsif number == "5"
        #     puts "Assignee: "
        #     more_information?
        #   elsif number == "6"
        #     puts "Primary Class: "
        #     more_information?
        # end
  end

  def more_information?
    puts "Would you like more information on this patent? (y/n)"
      response = gets.strip
    if response == "y"
      menu
    elsif response != "n"
      puts "I don't understand."
      more_information?
    end
  end

end #End of class
