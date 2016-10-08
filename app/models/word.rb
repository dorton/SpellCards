class Word < ApplicationRecord
  belongs_to :week, dependent: :destroy
end
