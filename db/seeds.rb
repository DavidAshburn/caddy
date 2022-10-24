# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

all_discs = JSON.parse(File.read(Rails.root.join('db/pdga.json')))

all_discs.each do |disc|
	Disc.create(
		user_id: disc["user_id"],
		maker: disc['Maker'],
		model: disc['Model'],
		weight: disc['Weight'],
		diameter: disc['Diameter'],
		height: disc['Height'],
		depth: disc['Depth'],
		rimdiameter: disc['RimDiameter'],
		rimthickness: disc['RimThickness'],
		rimratio: disc['RimRatio'],
		rimconfig: disc['RimConfig'],
		flexibility: disc['Flexibility']
		)
end

User.create(
	email:"disc@golf.com",
	password: "discgolf",
	password_confirmation: "discgolf"
	)
