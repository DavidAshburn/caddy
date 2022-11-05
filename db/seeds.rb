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
		flex: disc['Flexibility']
		)
end

User.create(
	email:"disc@golf.com",
	password: "discgolf",
	password_confirmation: "discgolf"
	)

Course.create(
	id: 9999,                                                           
 	course_id: 4712,                                                 
 	name: "Genesee Valley Park",                                     
 	holes: "18",                                                     
 	city: "Rochester",                                               
 	state: "NY",                                                     
 	country: "United States",                                        
 	zipcode: "14620",                                                
 	reviews: "7",                                                    
 	rating: "3.29",                                                  
 	private: "0",                                                    
 	paytoplay: "0",
 	tee_1_clr: "FF0000",
 	tee_2_clr: "",
 	tee_3_clr: "",
 	tee_4_clr: "",
 	dgcr_url: "https://www.dgcoursereview.com/course.php?id=4712",
	dgcr_mobile_url: "https://www.dgcoursereview.com/mobile/course.php?id=4712",
 	rating_img: "https://www.dgcoursereview.com/images/rating/discs_3.5.png",
 	rating_img_small:
  	"https://www.dgcoursereview.com/images/rating/discs_sm_3.5.png",
	photo_thumb: nil,
 	photo_medium: nil,
 	photo_hole: nil,
 	photo_cap: nil,
 	created_at: nil,
 	updated_at: nil,
 	latitude: "43.119428",
 	longitude: "-77.636679",
 	street_addr: "99 Elmwood Ave.",
 	creator: nil
 	)

Card.create(
	score: 63,
	shots: "42B0311A021A0321A021A021A0321B031B031C042B031A021B021A0211A05211C0321B031A0321C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 60,
	shots: "42B031A021C021A0211A0211B0321B0321A031C02B031A021B021A0211C0211A0321B031A031C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 59,
	shots: "42B01A021A021A0211A0211A031B0321C031C042B031A021A021A0211C0211A0321B031A031C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 64,
	shots: "22B031C0211A021B0211A021A0321B0321A031C022B031A021A021C0221A05211A0521C0321A03C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 61,
	shots: "32B031A021C021A021A05211A032B0321B031C042B031A021A021C0211A021A0321B0321A021C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 62,
	shots: "42B011A021A021A0211A04211A0321B0321B041C042B031A021A021A0211A0221C021C0321A031C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 62,
	shots: "32B031B011A021B022B05211A0321B0321A021C042B031A021A021C0211A0211A0311C021A011C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 60,
	shots: "32B031A031A021A0211B0211A0321B0321C031C041C031A021B021A0211A0211A021B0321A01C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 62,
	shots: "42B01A021A021A0211B0211C031B0321A031C042A031B021A021A0211B05211A0221C0321B031C0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Card.create(
	score: 62,
	shots: "42B032B021B021A0211A0211C021B0321A031C042C01A021A021A0211B05211A0321B0321A031A0",
	length: 18,
	tee: 1,
	course_id: 9999,
	user_id: 1,
	pars: "333333333343333334"
	)

Coursekey.create(
	user_id: 1,
	course_id: 9999,
	)