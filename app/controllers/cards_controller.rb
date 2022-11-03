class CardsController < ApplicationController
  before_action :set_card, only: %i[ show update destroy ]

  # GET /cards or /cards.json
  def index
    @cards = Card.where(user_id: current_user.id)
    @courses = current_user.courses
  end

  # GET /cards/1 or /cards/1.json
  def show
    @course = Course.find_by(id: @card.course_id)
    @pars = @course.holepins.map { |item| item.attributes["tee_#{@card.tee}_par"] }
  end

  # GET /cards/new
  def new
    @card = Card.new
    @tee = params[:tee]
    @course = Course.find_by(course_id: params[:course_id])
    @pars = @course.holepins.map{ |item| item.attributes["tee_#{@tee}_par"] }
    @length = @course.holepins.count
    
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
        #CourseKey creation/increment
        @notplayed = true;

        current_user.coursekeys.each do |key|
          if key.pointer = @card.course_id
            key.count = key.count + 1
            @notplayed = false
          end
        end
        if(@notplayed)
          @key = Coursekey.new()
          @key.course_id = @card.course_id
          @key.user_id = @card.user_id
          @key.save
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:score, :shots, :length, :user_id, :course_id, :tee, :count, :pointer)
    end
end