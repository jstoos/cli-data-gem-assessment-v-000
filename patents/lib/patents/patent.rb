require_relative "../patents.rb"

class Patents::Patent

  attr_accessor :doc, :number, :title, :inventors, :application_number, :publication_date, :filing_date, :assignee, :primary_class

  @@attributes = ["title", "inventors", "application_number", "publication_date", "filing_date", "assignee", "primary_class"]

  def initialize(number)
    @number = number
    get_page
    #attributes
    #binding.pry
  end

  def get_page
    url = "http://www.freepatentsonline.com/#{@number}.html"

    #Rescue 404 errors
    begin
      file = open(url)
      @doc = Nokogiri::HTML(file) do
        # handle doc
      end
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        # handle 404 error
      else
        raise e
        attributes
      end
    end
    #end online idea

    # file = open(url, 'User-Agent' => 'Chrome')
  end

  def attributes
    @@attributes.each do |attribute|
      attribute_capitalize = (attribute.split("_").collect {|word| word.capitalize}).join(" ")
      attribute_data = @doc.xpath('//div[contains(text(),"' + attribute_capitalize + '")]/following-sibling::div').text.strip.split("\n")
      attribute_data = attribute_data.collect {|name| name.strip}
      self.send("#{attribute}=", attribute_data)
      #binding.pry
    end
  end

end
