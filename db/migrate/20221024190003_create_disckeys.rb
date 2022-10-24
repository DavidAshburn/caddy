class CreateDisckeys < ActiveRecord::Migration[7.0]
  def change
    create_table :disckeys do |t|
      t.references :disc, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
