class ExchangeWeightForPreference < ActiveRecord::Migration[5.1]
  # Changes the weight column (integer) to a preference column (string) with five possible values

  def up
    vote_weights = Hash.new

    Vote.all.each do |vote|
      vote_weights[vote.id] = vote.weight
    end

    add_column :votes, :preference, :string, limit: 40
    Vote.reset_column_information

    vote_weights.each do |id, weight|
      updated_vote = Vote.find(id)

      if weight.nil?
        updated_vote.preference = :neutral
      else
        if weight > 1
          updated_vote.preference = :very_positive
        elsif weight == 1
          updated_vote.preference = :positive
        elsif weight == 0
          updated_vote.preference = :neutral
        elsif weight == -1
          updated_vote.preference = :negative
        elsif
          updated_vote.preference = :very_negative
        end
      end

      updated_vote.save!
    end

    remove_column :votes, :weight
  end
 
  def down
    vote_preferences = Hash.new

    Vote.all.each do |vote|
      vote_preferences[vote.id] = vote.preference
    end

    add_column :votes, :weight, :integer
    Vote.reset_column_information

    Vote.find_each do |vote|
      preference = vote_preferences[vote.id].to_sym

      if preference == :very_positive
        vote.weight = 2
      elsif preference == :positive
        vote.weight = 1
      elsif preference == :negative
        vote.weight = -1
      elsif preference == :very_negative
        vote.weight = -2
      else
        vote.weight = 0
      end

      vote.save!
    end

    remove_column :votes, :preference
  end
end
