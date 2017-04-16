# == Schema Information
#
# Table name: recipes
#
#  id                       :integer          not null, primary key
#  title                    :string
#  description              :text
#  instructions             :text
#  prep_time                :time
#  active_time              :time
#  total_time               :time
#  serving_size             :integer
#  serving_size_description :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  image                    :string
#

class Recipe < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :ingredients
end
