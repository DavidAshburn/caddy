class CreateHolepins < ActiveRecord::Migration[7.0]
  def change
    create_table :holepins do |t|
      t.integer :number
      t.string :label
      t.integer :tee_1_len
      t.integer :tee_2_len
      t.integer :tee_3_len
      t.integer :tee_4_len
      t.integer :tee_1_par
      t.integer :tee_2_par
      t.integer :tee_3_par
      t.integer :tee_4_par
      t.integer :course_id

      t.timestamps
    end
    add_index :holepins, :course_id
  end
end
