class SubCategory < ApplicationRecord
  #self.primary_key = :id
  has_many :catPropertyModels
  has_many :rules
  belongs_to :sub_categories, class_name: "SubCategory", optional: true
  has_many :sub_categories, class_name: "SubCategory", foreign_key: :sub_categories_id
  #,inverse_of: :subcategories
  #accepts_nested_attributes_for :subcategories
end
