class ImportController < ApplicationController
  def json
  
  # http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
  require 'open-uri'
  # https://github.com/flori/json
  require 'json'
  # http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
  require 'pp'
   
  request_uri = 'https://s3-ap-southeast-1.amazonaws.com/kiyo-development/test/categories.json'
  request_query = ''
  url = "#{request_uri}#{request_query}"

  # Actually fetch the contents of the remote URL as a String.
  buffer = open(url).read

  # Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
  result = JSON.parse(buffer)
  # An example of how to take a random sample of elements from an array. Pass the number of elements you want into .sample() method. It's probably a better idea for the server to limit the results before sending, but you can use basic Ruby skills to trim & modify the data however you'd like.
  # result = result.sample(5)
  #subcat = result[1]
  # Loop through each of the elements in the 'result' Array & print some of their attributes.
  result.each do |subcat|
   puts "id: #{subcat['id']}\t#{subcat['isLeaf']}\t#{subcat['firstLevelCatId']}\n"
   #puts "Registered: #{subcat['created_at']}\n\n"
   if !subcat['isLeaf'] && !subcat['subcategories'].nil?
    getSubCatagories(subcat['subcategories'], 0)
   end
  end
  puts "Finished!\n\n" 
  end  

  private
  def getSubCatagories(params, level)
    #puts "hello! getSubCatagories\n"
    level = level + 1
    params.each do |param|
      puts "-" * level + ">#{param['id']}\t#{param['isLeaf']}\t#{param['firstLevelCatId']}\n"
      if !param['isLeaf'] && !param['subcategories'].nil?
        getSubCatagories(param['subcategories'], level)
      end
    end
  end
end
