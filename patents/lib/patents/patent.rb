require_relative "../patents.rb"

class Patents::Patent

  attr_accessor :doc, :number, :title, :inventor, :application_number, :publication_date, :filing_date, :assignee, :primary_class

  def initialize(number)
    @number = number
    get_page
    attributes
    #binding.pry
  end

  def get_page
    # url = "http://www.freepatentsonline.com/#{@number}.html"
    # file = open(url, 'User-Agent' => 'Chrome')
    # @doc = Nokogiri::HTML(file)
    #binding.pry
  end

  def attributes
    @title = "A fake title"
    @inventor = "A fake inventor"
    # @title = @doc.css(".disp_doc2 .disp_elm_text b").first.text.strip
    # @inventor = @doc.xpath('//div[contains(text(),"Inventors:")]/following-sibling::div').text.strip
    # @application_number = @doc.xpath('//div[contains(text(),"Application Number:")]/following-sibling::div').text.strip
    # @publication_date = @doc.xpath('//div[contains(text(),"Publication Date:")]/following-sibling::div').text.strip
    # @filing_date = @doc.xpath('//div[contains(text(),"Filing Date:")]/following-sibling::div').text.strip
    # @assignee = @doc.xpath('//div[contains(text(),"Assignee:")]/following-sibling::div').text.strip
    # @primary_class = @doc.xpath('//div[contains(text(),"Primary Class:")]/following-sibling::div').text.strip
  end

end

#doc.css(".disp_doc2.disp_elm_title[att~=Inventors] .disp_elm_text").text is empty ""
#doc.css(".disp_doc2.disp_elm_title[att~=Inventors]").text is empty ""
#doc.css(".disp_elm_title[att~='Inventors'] + .disp_elm_text") trying to do siblgin, also empty
#doc.css(".disp_elm_title[text~='Inventors'] + .disp_elm_text").text also empty
#doc.css(".disp_elm_title + .disp_elm_text").text gives too many elements
#doc.css(".disp_doc2.disp_elm_title + .disp_elm_text") empty
#doc.css(".disp_doc2 .disp_elm_title + .disp_elm_text") too many elements
#doc.css(".disp_doc2 .disp_elm_title[text~='Inventors'] + .disp_elm_text") empty
#doc.css(".disp_doc2 .disp_elm_title[att~='Inventors'] + .disp_elm_text") empty
#doc.css(".disp_doc2 .disp_elm_title[att~='Inventors'] + .disp_elm_text")

#Patents::Patent.new(8765432).title
#doc.css(".disp_doc2 .disp_elm_title") + doc.css(".disp_elm_text") this gets all attributes
#doc.css(".disp_doc2 .disp_elm_title[Inventors]") + doc.css(".disp_elm_text") gives whole thing as well but don't see inventors
#doc.css(".disp_doc2 .disp_elm_title[Inventors#{:}]") + doc.css(".disp_elm_text") broken
#doc.css(".disp_doc2 .disp_elm_title") + doc.css(".disp_elm_text")
#doc.css(".disp_doc2 .disp_elm_title[Inv]") + doc.css(".disp_elm_text")
#doc.css(".disp_doc2 .disp_elm_title").tag_name
#doc.css(".disp_doc2").select {|attribute| attribute.include?("Inventors:")} empty set
#doc.css(".disp_doc2 .disp_elm_title[text~=Inv]") empty set

#(doc.css(".disp_doc2 .disp_elm_title") + doc.css(".disp_elm_text")).select {|attribute| attribute.include?("Inventors:")} empty
#(doc.css(".disp_doc2 .disp_elm_title") + doc.css(".disp_elm_text")).text Text but no way to select things

#doc.css(".disp_elm_text").select {|attribute| attribute.include?("Inventors:")} empty
#doc.css(".disp_doc2") + doc.css(".disp_elm_text")
#(doc.css(".disp_elm_title") + doc.css(".disp_elm_text")).text Gets all data but not headers
#USE THIS FOR BASE:  (doc.css(".disp_elm_title") + doc.css(".disp_elm_text"))  USE THIS FOR BASE
#doc.css(".disp_elm_text").select {|attribute| puts attribute}
#(doc.css(".disp_doc2 .disp_elm_title") + doc.css(".disp_elm_text")).select {|attribute| attribute.include?("Inv")} + doc.css(".disp_elm_text")).select {|attribute| attribute.include?("Inv")}
