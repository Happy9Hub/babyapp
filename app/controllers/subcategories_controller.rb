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
     #   @SubCategories = subCategories_data.each do |subCategory_data|
            puts "#{subCategory_data['id']}\t#{subCategory_data['isLeaf']}\t#{subCategory_data['firstLevelCatId']}\n"
            puts "#{subCategory_data['name']}\t#{subCategory_data['label']}\t#{subCategory_data['lscSetId']}\n"
            puts "#{subCategory_data['catPropertyModels']}\t#{subCategory_data['rules']}\n"
            puts "#{subCategory_data['active']}\t#{subCategory_data['variationCat']}\n"
            
            @newsubcategory = SubCategory.new
            @newsubcategory.id = subCategory_data['id']
            @newsubcategory.name = subCategory_data['name']
            @newsubcategory.label = subCategory_data['label']
            @newsubcategory.isLeaf = subCategory_data['isLeaf']
            @newsubcategory.firstLevelCatId = subCategory_data['firstLevelCatId']
            @newsubcategory.lscSetId = subCategory_data['lscSetId']
            @newsubcategory.active = subCategory_data['active']
            @newsubcategory.variationCat = subCategory_data['variationCat']
            #@newsubcategory.catPropertyModels = subCategories_data['catPropertyModels']
            #@newsubcategory.rules = subCategories_data['rules']
            
            puts "#{@newsubcategory.id}\t#{@newsubcategory.save}"
            puts @newsubcategory.errors.messages

            if !subCategory_data['isLeaf'] && !subCategory_data['subcategories'].nil?
              # getSubCatagories(@newsubcategory.id, subCategory_data['subcategories'], 0)
            end
    #    end 

        #@SubCategories.select(&:persisted?)

        #@SubCategory = Sub_category.new
        @SubCategories = SubCategory.find(@newsubcategory.id)
        #puts SubCategory.column_names
    end

    private
    def getSubCatagories(parent_id, params, level)
        #puts "hello! getSubCatagories\n"
        level = level + 1
       params.each do |param|
            puts "-" * level + ">#{param['id']}\t#{param['isLeaf']}\t#{param['firstLevelCatId']}\t#{parent_id}\n"

            @parent_subcategory = SubCategory.find_by(id: parent_id)
            puts "@parent_subcategory\t#{@parent_subcategory.id}\n"
            @newsubcategory =  SubCategory.new
            @newsubcategory.id = param['id']
            @newsubcategory.name = param['name']
            @newsubcategory.label = param['label']
            @newsubcategory.isLeaf = param['isLeaf']
            @newsubcategory.firstLevelCatId = param['firstLevelCatId']
            @newsubcategory.lscSetId = param['lscSetId']
            @newsubcategory.active = param['active']
            @newsubcategory.variationCat = param['variationCat']
            @newsubcategory.sub_categories_id = @parent_subcategory.id
            #@newsubcategory.catPropertyModels = subCategories_data['catPropertyModels']
            #@newsubcategory.rules = subCategories_data['rules']
            
            puts "#{@newsubcategory.id}\t#{@newsubcategory.save}"
            puts @newsubcategory.errors.messages

            if !param['isLeaf'] && !param['subcategories'].nil?
                #getSubCatagories(param['id'],param['subcategories'], level)
            end
       end
    end
    #def subCategory_params
    #    params.require(:subCategory).permit(:email, :password, :confirmed_password, :account_type, :user_username, :user_hash, :user_last_update)
    #end

end
