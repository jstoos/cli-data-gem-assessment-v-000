require_relative "../patents.rb"

class Patents::Patent

  attr_accessor :doc, :number, :title, :inventors, :application_number, :publication_date, :filing_date, :assignee, :primary_class

  @@attributes = ["title", "inventors", "application_number", "publication_date", "filing_date", "assignee", "primary_class"]

  def initialize(number)
    @number = number
    get_page
    attributes
    #binding.pry
  end

  def get_page
    url = "http://www.freepatentsonline.com/#{@number}.html"
    file = open(url, 'User-Agent' => 'Chrome')
    @doc = Nokogiri::HTML(file)
    #binding.pry
  end

  def attributes
    @@attributes.each do |attribute|
      attribute_capitalize = (attribute.split("_").collect {|word| word.capitalize}).join(" ")
      attribute_data = @doc.xpath('//div[contains(text(),"' + attribute_capitalize + '")]/following-sibling::div').text.strip
      self.send("#{attribute}=", attribute_data)
      binding.pry
    end
  end

end
