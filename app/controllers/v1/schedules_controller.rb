class V1::SchedulesController < V1::ApplicationController
  respond_to :json

  before_action :authenticate_user!
  before_action :schedules

  def index
    @schedules = schedules

    respond_with @schedules
  end

  def show
    @schedule = schedules.find_by!(uuid: params[:id])

    respond_with @schedule
  end

  def new
    @schedule = schedules.new

    respond_with @schedule
  end

  def create
    @schedule = schedules.new(schedule_params)
    @schedule.save

    respond_with @schedule
  end

  def edit
    @schedule = schedules.find_by!(uuid: params[:id])

    respond_with @schedule
  end

  def update
    @schedule = schedules.find_by!(uuid: params[:id])
    @schedule.update_attributes(schedule_params)

    respond_with @schedule
  end

  def destroy
    @schedule = schedules.find_by!(uuid: params[:id])
    @schedule.destroy

    respond_with @schedule
  end


  def on_call
    @schedule = schedules.find_by!(uuid: params[:id])

    respond_with @schedule.current_user_on_call
  end

  private

  def schedule_params
    params.permit(:name, :time_zone)
  end

  def schedules
    @schedules = Schedule.all
  end
end
