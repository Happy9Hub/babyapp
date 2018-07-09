class CreateSubCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_categories, id:false do |t|
      t.integer :id
      t.string :name
      t.string :label
      t.boolean :isLeaf
      t.references :catPropertyModels
      t.references :rules
      t.integer :firstLevelCatId
      t.integer :lscSetid
      t.boolean :variationCat
      t.boolean :ative
      t.references :subcategories

      t.timestamps
    end
  end
end
