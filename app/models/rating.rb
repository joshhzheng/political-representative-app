class Rating < ApplicationRecord
  belongs_to :news_item

  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: false
end
