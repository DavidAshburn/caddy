class AddLocToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :latitude, :string
    add_column :courses, :longitude, :string
    add_column :courses, :street_addr, :string
    add_column :courses, :creator, :integer
  end
end
