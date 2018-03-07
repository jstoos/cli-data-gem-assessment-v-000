require_relative "../patents.rb"

class Patents::Scraper

  attr_accessor :title, :number, :patent

  def initialize(patent_number)
    @number = patent_number
    @patent = Patents::Patent.new(@number, @title)
    get_page
  end

  def get_page #goes to the patent corresponding to the patent number entered
    url = "http://www.freepatentsonline.com/#{@number}.html"

    begin #Rescues errors
      file = open(url)
          # file = open(url, 'User-Agent' => 'Chrome')
      @doc = Nokogiri::HTML(file)
    rescue OpenURI::HTTPError => e
        @title = "invalid" # handle 404 error
    else # gets and assigns attributes if the patent does exits
      attributes
    end

  end

  def attributes
    Patents::Patent.attributes.each do |attribute|
      attribute_data = attribute_scraper(attribute)
      @patent.send("#{attribute}=", attribute_data)
    end
  end

  def attribute_scraper(attribute)
    attribute_capitalize = attribute_capitalize(attribute)
    attribute_data = @doc.xpath('//div[contains(text(),"' + attribute_capitalize + '")]/following-sibling::div').text.strip.split("\n")
    attribute_data = attribute_data.collect {|name| name.strip}
  end

  def attribute_capitalize(attribute)
      attribute_capitalize = (attribute.split("_").collect {|word| word.capitalize}).join(" ")
  end

end
