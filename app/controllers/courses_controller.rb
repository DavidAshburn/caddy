class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :set_states, only: %i[ index ]

  # GET /courses or /courses.json
  def index
    
    #on a form submission we'll get these params
    if params[:fcity].present? 
      city = params[:fcity].downcase
    end
    if params[:fstate].present? 
      state = params[:fstate]
    end
    if params[:fcountry].present? 
      country = params[:fcountry]
    end
    
    if(city && state && country)
      @courses = Array.new
      @loc = Location.create(address: "#{city},#{state},#{country}")
      list = near_rad(@loc.latitude, @loc.longitude, 15)
      list.each do |course|
        #we'll save them to the database if they don't already exist
        if !Course.find_by(course_id: course.course_id)
          if !course.save 
            format.html { render courses, status: :unprocessable_entity }
          end
        end
        @courses.push(Course.find_by(course_id: course.course_id))
      end
      @loc.destroy
    else
      @courses = current_user.courses
    end
  end

  # GET /courses/1 or /courses/1.json
  def show
    @cards = current_user.cards.select { |card| card.course_id == @course.id }
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course added." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Disc was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    #for state select box in index once DGCR API leaves test mode
    def set_states
      states = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']
      @statelist = []
      
      states.each_with_index do |state, i|
        @statelist.push([state,i+1])
      end
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:course_id, :name, :holes, :city, :state, :country, :zipcode, :latitude, :longitude, :street_addr, :reviews, :rating, :private, :paytoplay, :tee_1, :tee_2, :tee_3, :tee_4, :dgcr_url, :rating_img, :rating_img_small, :photo_thumb, :photo_medium, :photo_cap, :photo_hole, :creator, :fcity, :fstate, :fcountry)
    end

    def near_rad(lat, lon, radius)
      signature = Digest::MD5.hexdigest "#{ENV['DGCR_KEY']}#{ENV['DGCR_SEC']}near_rad"
      uri = URI("https://www.dgcoursereview.com/api_test/?key=#{ENV['DGCR_KEY']}&mode=near_rad&lat=#{lat}&lon=#{lon}&limit=24&rad=#{radius}&sig=#{signature}")
      response = Net::HTTP.get(uri)
      list = JSON.parse(response)
      courses = Array.new
      list.each do |item|
        courses.push(Course.new(item.except("distance")))
      end
      return courses
    end
end
