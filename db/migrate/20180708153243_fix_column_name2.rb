class FixColumnName2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :sub_categories, :firstLevelCatid, :firstLevelCatId
    rename_column :sub_categories, :lscSetid, :lscSetId
  end
end
