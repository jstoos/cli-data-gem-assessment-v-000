#The Controller

class Patents::CLI

  attr_accessor :current_patent, :attribute

  @@attributes_title = ["Inventors", "Application Number", "Publication Date", "Filing Date", "Assignee", "Primary Class"]

  def call
    find_a_patent
  end

  def find_a_patent  #Begins the process of inviting the user to enter a patent number
    input = ""
    number = ""

    until input == "exit" do #gets input from the user
      puts "Please enter a patent number: (to exit enter 'exit')"
      input = gets.strip
      number = input.to_i
      @current_patent = Patents::Patent.new(number) #creates a new patent object

      if valid_number?(input)
          puts "Patent number #{number} is entitled: #{@current_patent.title[0]}"
          puts ""
          menu #Offer the user the chance to get information on that patent
      elsif input != "exit"
          puts ""
          puts "That is not a valid patent number."
          puts ""
      end

    end
  end

  def valid_number?(number)
    number.to_i.between?(100000, 99999999) && @current_patent.title != nil
  end

  def menu
    puts "What information would you like about this patent? (Please enter a number)"
    counter = 0
    @@attributes_title.each do |attribute| #creating menu
      counter +=1
      puts "#{counter}. #{attribute}"
    end
      puts "#{@@attributes_title.size+1}. Enter a New Patent number or exit"

      number = gets.strip #making sure they are entering a number from the menu
        while !number.to_i.between?(1, (@@attributes_title.size + 1))
          puts "Please enter a number between 1 and 7:"
          number = gets.strip
        end

      if number != "7" #unless they enter 'exit' finds the requested attribute
        current_patent_info = @current_patent.send("#{Patents::Patent.attributes[number.to_i]}")
        puts ""
        puts  "#{@@attributes_title[number.to_i-1]}: "
        "#{current_patent_info.collect {|item| puts item}}"
        puts ""
      end

      if number.to_i.between?(1, (@@attributes_title.size))
        more_information?
      end

  end

  def more_information? #continues to offer more information
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
