class Vote < ApplicationRecord
  # Possible preferences:
  #  :very_positive
  #  :positive
  #  :neutral
  #  :negative
  #  :very_negative

  belongs_to :proposal
  belongs_to :voter

  validates :voter_id, uniqueness: {scope: :proposal_id}
  validates :proposal_id, uniqueness: {scope: :voter_id}
end
