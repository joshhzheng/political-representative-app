# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :news_item
  RATINGS = (1..5).freeze

  validates :score, presence: true, inclusion: { in: RATINGS }
  validates :comment, presence: false

  def self.rating_scores
    RATINGS
  end
end
