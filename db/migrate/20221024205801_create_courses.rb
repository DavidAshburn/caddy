class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.integer :dgcr_id
      t.string :name
      t.integer :holes
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.integer :reviews
      t.float :rating
      t.integer :private
      t.integer :paytoplay
      t.string :tee_1
      t.string :tee_2
      t.string :tee_3
      t.string :tee_4
      t.string :dgcr_url
      t.string :rating_img
      t.string :rating_img_small
      t.string :photo_thumb
      t.string :photo_medium
      t.string :photo_hole
      t.string :photo_cap

      t.timestamps
    end
  end
end
