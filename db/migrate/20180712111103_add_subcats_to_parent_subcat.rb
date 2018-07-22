class AddSubcatsToParentSubcat < ActiveRecord::Migration[5.2]
  def change
    #change_column :sub_categories, :id, :integer
    add_reference :sub_categories, :sub_categories#, foreign_key: true
    #add_foreign_key :sub_categories, :sub_categories, column: :subcategories_id, primary_key: :id
  end
end
