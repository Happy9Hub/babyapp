class CategoryService
    def initialize
        @categories = Hash.new
        @catandsubcat = Hash.new
    end
    def append(idCategory,aCategory)
        #puts "#{aCategory.id}\t#{aCategory.firstLevelCatId}\t#{idCategory}\n"
        @categories[idCategory] = aCategory
        #self
    end
    def appendCatAndSubcat(idCategory,idSubcategory)
        #puts "#{idCategory}\t#{idSubcategory}\n"
        if @catandsubcat[idCategory].nil?
            @subcategories = [idSubcategory]
            @catandsubcat[idCategory] = @subcategories
        else
            arrSubcat = @catandsubcat[idCategory]
            arrSubcat.push(idSubcategory)
            @catandsubcat[idCategory] = arrSubcat
        end
    end
    def showallcatandsubcat
        @catandsubcat.each do |idCategory,idSubcategories|
            idSubcategories.each do |idSubcategory|
                puts "#{idCategory}\t#{idSubcategory}\n"
            end
        end
    end
    def findbyid(idCategory)
        return @categories[idCategory]
    end
    def findSubcatByIdCat(idCatParam)
        @showallsubcat = Hash.new
        idSubcategories = @catandsubcat[idCatParam]
        idSubcategories.each do |idSubcategory|
            @showallsubcat[idSubcategory] = @categories[idSubcategory]
            #puts "#{@selectedCat[idCategory].id}\n"
        end
        return @showallsubcat
    end
    def findSubcatByFirstLevelCatId(idCatParam)
        @showallsubcat = Hash.new
        @categories.each do |idCategory,aCategory|
            #puts "#{aCategory.isLeaf}\t#{aCategory.firstLevelCatId.to_s}\t#{idCatParam.to_s}\n"
            if (aCategory.isLeaf) && (aCategory.firstLevelCatId.to_s == idCatParam.to_s)
                @showallsubcat[idCategory] = aCategory
                #puts "#{@selectedCat[idCategory].id}\n"
            end
        end
        return @showallsubcat
    end
    def findbyname(nameCategory)
        @selectedCat = Hash.new
        @categories.each do |idCategory,aCategory|
            if (aCategory.name).include?(nameCategory)
                @selectedCat[idCategory] = aCategory
                #puts "#{@selectedCat[idCategory].id}\n"
            end
        end
        return @selectedCat
    end
    def showallrootcat
        @showallcat = Hash.new
        @categories.each do |idCategory,aCategory|
            puts "#{aCategory.id}\t#{aCategory.firstLevelCatId}\t#{idCategory}\n"
            if (aCategory.id.to_i == aCategory.firstLevelCatId.to_i)
                @showallcat[idCategory] = aCategory
                #puts "#{@showallcat[idCategory].id}\n"
            end
        end
        return @showallcat
    end
    def showallsubcategories
        @showallsubcat = Hash.new
        @categories.each do |idCategory,aCategory|
            if aCategory.isLeaf
                @showallsubcat[idCategory] = aCategory
                #puts "#{@selectedCat[idCategory].id}\n"
            end
        end
        return @showallsubcat
    end
    def printallkeys
        puts @categories.keys
    end
    def deleteFirst
        # @categories.shift
    end
    def deleteLast
        # @categories.pop
    end
end