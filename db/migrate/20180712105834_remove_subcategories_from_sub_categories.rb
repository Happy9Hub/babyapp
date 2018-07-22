class RemoveSubcategoriesFromSubCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :sub_categories, :subcategories_id
  end
end
