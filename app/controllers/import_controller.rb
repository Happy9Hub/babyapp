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
  # cat_data = result[3] #For testing some item
  # Loop through each of the elements in the 'result' Array & print some of their attributes.
  $categoryService = CategoryService.new
  result.each do |cat_data|
   #puts "id: #{cat_data['id']}\t#{cat_data['isLeaf']}\t#{cat_data['firstLevelCatId']}\t"
   #puts "#{cat_data['name']}\n"
   @newcategory = Category.new(cat_data['id'], cat_data['name'], cat_data['label'], cat_data['isLeaf'], nil, nil,
   cat_data['firstLevelCatId'], cat_data['lscSetId'], cat_data['variationCat'], cat_data['active'], nil)

   $categoryService.append(@newcategory.id, @newcategory)
   #puts "id: #{@newcategory.id}\t#{@newcategory.isLeaf}\t#{@newcategory.firstLevelCatId}\t"
   #puts "#{cat_data['name']}\n"

   if !cat_data['isLeaf'] && !cat_data['subcategories'].nil?
    getSubCatagories(cat_data['id'], cat_data['subcategories'], 0)
   end
  end
  #$categoryService.showallcatandsubcat()
  puts "Finished!\n\n" 
  @showallcategories = $categoryService.showallrootcat()
  #@selectedCat = $categoryService.findbyname("กล้อง")
  end

  def search
    puts params[:textSearch]

    @searchCategories = $categoryService.findbyname(params[:textSearch])

    @searchCategories.each do |idCategory,cat_data|
      puts "id: #{cat_data.id}\t#{cat_data.isLeaf}\t#{cat_data.firstLevelCatId}\t"
      puts "#{cat_data.name}\n"
    end
   render params[:@searchCategories]
  end
  
  def showsubcategories
    puts params[:idCategory]
    @showSubcategories = Hash.new
    @category = $categoryService.findbyid(params[:idCategory].to_i)
    @showSubcategories[params[:idCategory].to_i] = @category
    @showSubcategories = @showSubcategories.merge($categoryService.findSubcatByIdCat(params[:idCategory].to_i))

    @showSubcategories.each do |idCategory,cat_data|
      puts "id: #{cat_data.id}\t#{cat_data.isLeaf}\t#{cat_data.firstLevelCatId}\t"
      puts "#{cat_data.name}\n"
    end
   render params[:@showSubcategories]
  end

  def showidcategory
    puts params[:idCategory]
    @showidcategory = $categoryService.findbyid(params[:idCategory].to_i)
    render params[:@showidcategory]
  end

  private

  def getSubCatagories(parentCatId, params, level)
    #puts "hello! getSubCatagories\n"
    level = level + 1
    params.each do |param|
      #puts "-" * level + ">#{param['id']}\t#{param['isLeaf']}\t#{param['firstLevelCatId']}\n"
      @newcategory = Category.new(param['id'], param['name'], param['label'], param['isLeaf'], nil, nil,
      param['firstLevelCatId'], param['lscSetId'], param['variationCat'], param['active'], nil)

      $categoryService.append(param['id'], @newcategory)
      $categoryService.appendCatAndSubcat(parentCatId, param['id'])
      if !param['isLeaf'] && !param['subcategories'].nil?
        getSubCatagories(param['id'], param['subcategories'], level)
      end
    end
  end
end
