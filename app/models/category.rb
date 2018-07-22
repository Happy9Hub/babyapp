class Category

    def initialize(id, name, label, isLeaf, catPropertyModels, rules, firstLevelCatId,
        lscSetid, variationCat, active, subcategories)
        @id = id
        @name = name
        @label = label
        @isLeaf = isLeaf
        @catPropertyModels = catPropertyModels
        @rules = rules
        @firstLevelCatId = firstLevelCatId
        @lscSetid = lscSetid
        @variationCat = variationCat
        @active = active
        @subcategories = subcategories
    end
    attr_reader :id, :name, :label, :isLeaf, :catPropertyModels, :rules, :firstLevelCatId,
    :lscSetid, :variationCat, :active, :subcategories

end