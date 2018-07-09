class SubcategoriesController < ApplicationController
    def index
        require 'open-uri'
        require 'json'
        require 'pp'

        request_uri = 'https://s3-ap-southeast-1.amazonaws.com/kiyo-development/test/categories.json'
        request_query = ''
        url = "#{request_uri}#{request_query}"
        buffer = open(url).read
        subCategories_data = JSON.parse(buffer)
        subCategory_data = subCategories_data[0]
       # @SubCategories = subCategories_data.each do |subCategory_data|
            puts "#{subCategory_data['id']}\t#{subCategory_data['isLeaf']}\t#{subCategory_data['firstLevelCatId']}"
            
            subcategory = SubCategory.new
            subcategory.id = subCategory_data['id']
            subcategory.name = subCategory_data['name']
            subcategory.label = subCategory_data['label']
            subcategory.isLeaf = subCategory_data['isLeaf']
            subcategory.firstLevelCatId = subCategory_data['firstLevelCatId']
            subcategory.lscSetId = subCategory_data['lscSetId']
            subcategory.active = subCategory_data['active']
            subcategory.variationCat = subCategory_data['variationCat']
            
            if !subCategory_data['isLeaf']
            
            end
            subcategory.save
      #  end  

        #@SubCategories.select(&:persisted?)

        #@SubCategory = Sub_category.new
        #@SubCategories = SubCategory.all
    end


end
