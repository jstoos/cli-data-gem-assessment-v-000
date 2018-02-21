

class Patents::Patent

  attr_accessor :number, :title, :inventor, :application_number, :publication_date, :filing_date, :assignee, :primary_class

  def initialize(number)
    @number = number
  end

  def title
    puts "This is the title"
  end

  def attributes
  end

end
