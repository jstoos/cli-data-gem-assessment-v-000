#The Controller

class Patents::CLI

  attr_accessor :current_patent, :attribute

  @@attributes_title = ["Inventors", "Application Number", "Publication Date", "Filing Date", "Assignee", "Primary Class"]

  def call
    find_a_patent
  end

  def find_a_patent  #Begins the process of inviting the user to enter a patent number
    input = ""
    patent_number = ""

    until input == "exit" do #gets input from the user
      puts "Please enter a patent number: (to exit enter 'exit')"
      input = gets.strip
      patent_number = input.to_i
      @current_patent = Patents::Patent.new(patent_number) #creates a new patent object

      if valid_number?(input)
        if @current_patent.title[0] == nil
          puts "Unfortunatly that patent does not have a title"
        else
          puts "Patent number #{patent_number} is entitled: #{@current_patent.title[0]}"
        end
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
    create_menu

    number = gets.strip #making sure they are entering a number from the menu
      while !number.to_i.between?(1, (@@attributes_title.size + 1))
        puts "Please enter a number between 1 and #{@@attributes_title.size + 1}:"
        number = gets.strip
      end

    if number != "7" #unless they enter 'exit' finds the requested attribute
      current_patent_info = @current_patent.send("#{Patents::Patent.attributes[number.to_i]}")
      puts ""

      if current_patent_info.empty?
        puts "Unfortunately that information is not available."
      else
        puts  "#{@@attributes_title[number.to_i-1]}: "
        "#{current_patent_info.collect {|item| puts item}}"
        puts ""
      end

    end

    if number.to_i.between?(1, (@@attributes_title.size))
      more_information?
    end

  end

  def create_menu
    counter = 0
    @@attributes_title.each do |attribute| #creating menu
      counter +=1
      if @current_patent.send("#{Patents::Patent.attributes[counter]}").empty?
        puts "#{counter}. (#{attribute} is not available)"
      else
      puts "#{counter}. #{attribute}"
    end
    end
      puts "#{@@attributes_title.size+1}. Enter a New Patent number or exit"
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
