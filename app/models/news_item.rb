# frozen_string_literal: true

## TODO: could be useful to add method allowing creation of new
# ISSUES topics
## TODO: could be useful to add method calculating ratings

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  ISSUES = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare',
            'Abortion', 'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change',
            'Homelessness', 'Racism', 'Tax Reform', 'Net Neutrality', 'Religious Freedom',
            'Border Security', 'Minimum Wage', 'Equal Pay'].freeze

  validates :issue, presence: true, inclusion: { in: ISSUES }

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def average_rating
    ## Could be augmented to calculate average
    # for each news article
    ratings.average(:score).to_f
  end

  def self.issue_topics
    ISSUES
  end

  def self.rating_scores
    [1, 2, 3, 4, 5]
  end
end
