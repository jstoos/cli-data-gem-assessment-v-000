require_relative "../patents.rb"

class Patents::Patent

  attr_accessor :doc, :number, :title, :inventors, :application_number, :publication_date, :filing_date, :assignee, :primary_class

  @@attributes = ["title", "inventors", "application_number", "publication_date", "filing_date", "assignee", "primary_class"]
  @@patents_list = []

  def initialize(number, title) #creates a new patent object
    @number = number
    @@patents_list << self
  end

  def self.patents_list
    @@patents_list
  end
  
  def self.attributes
    @@attributes
  end

end


#Scrapper class
#=> CLI = 22222 => Scrapper => Patent.new(attributes) => CLI Display = 22222
#=> previous searches [22222, 22221]
