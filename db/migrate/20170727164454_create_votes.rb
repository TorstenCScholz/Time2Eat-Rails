class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :proposal, foreign_key: true
      t.references :voter, foreign_key: true
      t.integer :weight

      t.timestamps
    end

    add_index :votes, [:proposal_id, :voter_id], unique: true
  end
end
