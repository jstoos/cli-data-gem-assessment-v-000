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

  # def attributes
  #   # @title = "A fake title"
  #   # @inventor = "A fake inventor"
  #   #@title = @doc.css(".disp_doc2 .disp_elm_text b").first.text.strip
  #   @title = @doc.xpath('//div[contains(text(),"Title:")]/following-sibling::div').text.strip
  #   @inventor = @doc.xpath('//div[contains(text(),"Inventors:")]/following-sibling::div').text.strip
  #   @application_number = @doc.xpath('//div[contains(text(),"Application Number:")]/following-sibling::div').text.strip
  #   @publication_date = @doc.xpath('//div[contains(text(),"Publication Date:")]/following-sibling::div').text.strip
  #   @filing_date = @doc.xpath('//div[contains(text(),"Filing Date:")]/following-sibling::div').text.strip
  #   @assignee = @doc.xpath('//div[contains(text(),"Assignee:")]/following-sibling::div').text.strip
  #   @primary_class = @doc.xpath('//div[contains(text(),"Primary Class:")]/following-sibling::div').text.strip
  # end

end
