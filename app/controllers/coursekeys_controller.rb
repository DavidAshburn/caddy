class CoursekeysController < ApplicationController
  before_action :set_coursekey, only: %i[ show edit update destroy ]

  def new
    @coursekey = Coursekey.new
  end

  # POST /cards or /cards.json
  def create
    @coursekey = current_user.coursekeys.create!(coursekey_params)

    respond_to do |format|
      if @coursekey.save
        format.turbo_stream
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coursekey.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coursekey
      @coursekey = Coursekey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coursekey_params
      params.require(:coursekey).permit(:course_id, :user_id)
    end
end