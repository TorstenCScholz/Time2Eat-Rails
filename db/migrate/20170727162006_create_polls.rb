class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :name
      t.text :description
      t.string :status
      t.datetime :started_at
      t.datetime :concluded_at

      t.timestamps
    end
  end
end
