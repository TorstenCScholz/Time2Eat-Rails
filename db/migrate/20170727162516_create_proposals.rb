class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.references :poll, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
