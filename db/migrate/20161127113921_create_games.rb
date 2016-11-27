class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :state
      t.string :x_player

      t.timestamps

      t.index :x_player
    end
  end
end
