class Asset < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders history]

  belongs_to :neighborhood

  acts_as_taggable_on :categories

  validates_presence_of :name,
    :description,
    :name,
    :category_list,
    :lookup_address,
    :geo_geometry
    :geometry

  validate :valid_categories

  CATEGORIES =['cult', 'infrastructure', 'food_kitchen', 'public_organization', 'education', 'health', 'community_center'].freeze

  def self.categories
    CATEGORIES
  end

  def valid_categories
    if category_list.nil? || category_list.empty?
      errors.add(:category_list, "errors")
    end
  end

  def category
    self.tags_on(:categories).first
  end

  def category_icon
    category.blank? ? 'icons/category-editable.svg' : "icons/category-#{category}.svg"
  end

end
