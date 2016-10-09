class Week < ApplicationRecord
  has_many :words

  def show_date
    date.strftime('%B %d, %Y')
  end

end
