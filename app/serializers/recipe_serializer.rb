class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :instructions, :prep_time, :active_time,
             :total_time, :serving_size, :serving_size_description
end
