class WordSerializer < ActiveModel::Serializer
  attributes :id, :letters, :pic, :sound_url, :spelling_bee

  belongs_to :week_id
end
