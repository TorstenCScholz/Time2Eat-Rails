module PollsHelper
  def get_votes_for_voter(votes, voter)
    votes.where(voter_id: voter.id)
  end

  def get_vote_preference_for_poll_and_voter_and_item(poll, voter, item)
    proposal_id = Proposal.where(poll_id: poll.id, item_id: item.id).pluck(:id).first

    vote = Vote.where(voter_id: voter.id, proposal_id: proposal_id).first

    if vote.nil?
      :hide
    else
      vote.preference
    end
  end
end
