class Proposal < ApplicationRecord
  belongs_to :poll
  belongs_to :item
end
