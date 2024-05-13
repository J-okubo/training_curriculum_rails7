class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    @plan = Plan.create(plan_params)
    if @plan.save
      redirect_to '/'
    else
      redirect_to root_path
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    @todays_date = Date.today
    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

      days = {
        month:(@todays_date + x).month,
        date:(@todays_date+x).day,
        day_of_week: wdays[(@todays_date + x).wday],
        plans:today_plans }
        @week_days.push(days)
      end
  end
end
