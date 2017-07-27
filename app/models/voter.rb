class Voter < ApplicationRecord
  validates :name, uniqueness: true
end
