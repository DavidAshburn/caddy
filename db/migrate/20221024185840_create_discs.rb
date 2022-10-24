class CreateDiscs < ActiveRecord::Migration[7.0]
  def change
    create_table :discs do |t|
      t.string :maker
      t.string :model
      t.float :weight
      t.float :diameter
      t.float :height
      t.float :depth
      t.float :rimdiameter
      t.float :rimthickness
      t.float :rimratio
      t.float :rimconfig
      t.float :flex
      t.float :speed
      t.float :glide
      t.float :turn
      t.float :fade
      t.integer :user_id

      t.timestamps
    end
    add_index :discs, :user_id
  end
end
