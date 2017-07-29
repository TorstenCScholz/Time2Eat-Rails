module VotesHelper
  def get_poll_for_proposal(proposal)
    Poll.find(proposal.poll_id)
  end

  def get_item_for_proposal(proposal)
    Item.find(proposal.item_id)
  end
end
