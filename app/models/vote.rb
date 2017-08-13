class Vote < ApplicationRecord
  # TODO: Must convert to String as input is a String and not a symbol. What is a better way?!
  @allowed_preferences = [
    :very_positive.to_s,
    :positive.to_s,
    :neutral.to_s,
    :negative.to_s,
    :very_negative.to_s
  ]

  belongs_to :proposal
  belongs_to :voter

  validates :voter_id, uniqueness: {scope: :proposal_id}
  validates :proposal_id, uniqueness: {scope: :voter_id}
  validates :preference, inclusion: @allowed_preferences
end
