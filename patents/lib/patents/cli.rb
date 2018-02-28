#The Controller

class Patents::CLI

  attr_accessor :current_patent, :attribute

  @@attributes = [["Inventors", "inventors"], ["Application Number", "application_number"], ["Publication Date", "publication_date"], ["Filing Date", "filing_date"], ["Assignee", "assignee"], ["Primary Class", "primary_class"]]

  def call
    find_a_patent
  end

  def find_a_patent
    input = ""
    number = ""

    until input == "exit" do
      puts "Please enter a patent number: (to exit enter 'exit')"
      input = gets.strip

      if valid_number?(input)
        number = input.to_i
        @current_patent = Patents::Patent.new(number)
      #binding.pry
        if @current_patent.title != nil
          puts "Patent number #{number} is entitled: #{@current_patent.title}"
          puts ""
          menu #Offer the user the chance to get information on that patent
        else
          puts ""
          puts "That is not a valid patent number."
          puts ""
        end

      end

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
      puts "#{counter}. #{attribute[0]}"
    end
      puts "#{@@attributes.size+1}. Enter a New Patent number or exit"

      number = gets.strip
        while !number.to_i.between?(1, (@@attributes.size + 1))
          puts "Please enter a number between 1 and 7:"
          number = gets.strip
        end

      if number != "7"
        current_patent_info = @current_patent.send("#{@@attributes[number.to_i-1][1]}")
        puts ""
        puts  "#{@@attributes[number.to_i-1][0]}: "
        "#{current_patent_info.collect {|item| puts item}}"
        puts ""
      end

      if number.to_i.between?(1, (@@attributes.size))
        more_information?
      end

  end

  def more_information?
    puts "Would you like more information on this patent? (y/n)"
      response = gets.strip
    if response == "y"
      menu
    elsif response != "n"
      puts "I don't understand. Would you like more information on this patent? (y/n)"
      more_information?
    end
  end

end #End of class
