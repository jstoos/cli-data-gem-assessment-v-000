require_relative "../patents.rb"

class Patents::Patent

  attr_accessor :doc, :number, :title, :inventors, :application_number, :publication_date, :filing_date, :assignee, :primary_class

  @@attributes = ["title", "inventors", "application_number", "publication_date", "filing_date", "assignee", "primary_class"]

  def initialize(number) #creates a new patent object
    @number = number
    get_page
  end

  def get_page #goes to the patent corresponding to the patent number entered
    url = "http://www.freepatentsonline.com/#{@number}.html"

    begin #Rescues errors
      file = open(url)
          # file = open(url, 'User-Agent' => 'Chrome')
      @doc = Nokogiri::HTML(file)
    rescue OpenURI::HTTPError => e
        @title = nil # handle 404 error
    else # gets and assigns attributes if the patent does exits
      attributes
    end

  end

  def attributes # gets and assigns attributes for the patent object
    @@attributes.each do |attribute|
      attribute_capitalize = (attribute.split("_").collect {|word| word.capitalize}).join(" ")
      attribute_data = @doc.xpath('//div[contains(text(),"' + attribute_capitalize + '")]/following-sibling::div').text.strip.split("\n")
      attribute_data = attribute_data.collect {|name| name.strip}
      self.send("#{attribute}=", attribute_data)
    end
  end

end
