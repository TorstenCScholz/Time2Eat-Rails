json.extract! vote, :id, :proposal_id, :voter_id, :preference, :created_at, :updated_at
json.url vote_url(vote, format: :json)
