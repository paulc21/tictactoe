class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :state
      t.integer :x_player_id

      t.timestamps

      t.index :x_player_id
    end
  end
end
