class Week < ApplicationRecord
  has_many :words, through: :week_words, dependent: :destroy
  has_many :week_words

  def show_date
    date.strftime('%B %d, %Y')
  end

  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end

end
