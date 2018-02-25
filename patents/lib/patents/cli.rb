#The Controller

class Patents::CLI

  attr_accessor :current_patent, :attribute

  @@attributes = [["Inventor", "inventor"], ["Application Number", "application_number"], ["Publication Date", "publication_date"], ["Filing Date", "filing_date"], ["Assignee", "assignee"], ["Primary Class", "primary_class"]]

  def call
    find_a_patent
  end

  def find_a_patent
    input = ""
    number = ""

    until input == "exit" do
      puts "Please enter a patent number: (to exit enter 'exit')"    #Ask the user for a patent number
      input = gets.strip

      if valid_number?(input) #Check it is a valid number
        @current_patent = Patents::Patent.new(number) #Take that number, create a patent instantiation
        puts "Patent number #{input} is entitled: #{current_patent.title}"
        #puts "Inventor is #{current_patent.inventor}"
       menu  #Offer the user the chance to get information on that patent
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
      puts "#{counter}. #{attribute[0]}"
    end
      puts "#{@@attributes.size+1}. Enter a New Patent number or exit"

      number = gets.strip
        while !number.to_i.between?(1, (@@attributes.size + 1))
          puts "Please enter a number between 1 and 7:"
          number = gets.strip
        end

      current_patent_info = @current_patent.send("#{@@attributes[number.to_i-1][1]}")
      puts  "#{@@attributes[number.to_i-1][0]}: #{current_patent_info}"

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
