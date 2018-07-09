class SubCategory < ApplicationRecord
  has_many :catPropertyModels
  belongs_to :rules
  has_many :subcategories, inverse_of: :subcategories
  accepts_nested_attributes_for :subcategories
end
