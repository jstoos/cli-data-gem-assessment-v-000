#The Controller

class Patents::CLI

  attr_accessor :current_patent, :attribute

  @@attributes_title = []

  def call
    create_attributes_title
    patent_finder
  end

  def patent_finder  #Begins the process of inviting the user to enter a patent number
    input = ""
    patent_number = ""

    puts ""
    puts "Welcome to the Patent Finder Gem!"

    until input == "exit" do #gets input from the user
      puts "Please enter a patent number: (to exit enter 'exit')"
      input = gets.strip
      patent_number = input.to_i
      create_a_patent(patent_number)

      if valid_patent_number?(input)
        if @current_patent.title == []
          puts "Unfortunatly that patent does not have a title"
        else
          puts "Patent number #{patent_number} is entitled: #{@current_patent.title[0]}"
        end
        puts ""

        menu(patent_number) #Offer the user the chance to get information on that patent

      elsif input != "exit"
          puts ""
          puts "Whoops! That is not a valid patent number."
          puts ""
      end
    end
  end

  def create_a_patent(patent_number)
    @current_patent = Patents::Patent.new(patent_number) #creates a new patent object
  end

  def create_attributes_title
      Patents::Patent.attributes.each do |attribute|
        @@attributes_title << (attribute.split("_").collect {|word| word.capitalize}).join(" ")
      end
      @@attributes_title.shift
  end

  def valid_patent_number?(number)
    number.to_i.between?(100000, 99999999) && @current_patent.title != "invalid"
  end

  def menu(patent_number)
    puts "What information would you like about patent number #{patent_number}? (Please enter a number)"
    create_menu
    index_number = gets.strip #making sure they are entering a number from the menu
    valid_index_number(index_number)
    #find_requested_attribute(index_number)
  end

  def create_menu
    counter = 0
    @@attributes_title.each_with_index do |attribute, index| #creating menu
      i = index + 1
      if attribute != "Title" && i <= @@attributes_title.size
        if @current_patent.send("#{Patents::Patent.attributes[i]}").empty?
          puts "#{i}. (#{attribute} is not available)"
        else
          puts "#{i}. #{attribute}"
        end
      end
    end
      puts "#{@@attributes_title.size+1}. Enter a New Patent number or exit"
  end

  def  valid_index_number(index_number)
    while !index_number.to_i.between?(1, (@@attributes_title.size+1))
      puts "Please enter a number between 1 and #{@@attributes_title.size+1}:"
      index_number = gets.strip
    end
    find_requested_attribute(index_number)
  end

  def find_requested_attribute(index_number)
    if index_number.to_i != @@attributes_title.size+1 #unless they enter 'exit' finds the requested attribute
      current_patent_info = @current_patent.send("#{Patents::Patent.attributes[index_number.to_i]}")
      puts ""

      if current_patent_info.empty?
        puts "Unfortunately that information is not available."
      else
        puts  "#{@@attributes_title[index_number.to_i-1]}: "
        "#{current_patent_info.collect {|item| puts item}}"
        puts ""
      end

      more_information?(index_number.to_i)
    end
  end

  def more_information?(list_number) #continues to offer more information
    puts "Would you like more information on this patent? (y/n)"
      response = gets.strip
    if response == "y"
      menu(@current_patent.number)
    elsif response != "n"
      puts "I don't understand."
      more_information?(list_number)
    end
  end

end #End of class
