class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.integer :course_id
      t.string :name
      t.string :holes
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :reviews
      t.string :rating
      t.string :private
      t.string :paytoplay
      t.string :tee_1_clr
      t.string :tee_2_clr
      t.string :tee_3_clr
      t.string :tee_4_clr
      t.string :dgcr_url
      t.string :dgcr_mobile_url
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
