class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :update, :destroy]

  EARTH_RADIUS = 6378137.0

  # GET /activities
  # GET /activities.json
  # 查看全部活动
  # @param user_id
  # @param longitude 经度
  # @param latitude  纬度
  def index
    user_id = params['user_id'].to_i
    longitude = params['longitude'].to_d
    latitude = params['latitude'].to_d
    @activities = Activity.all
    @activities.each do |activity|
      activity.distance = gps2m(longitude, latitude, activity.location_longitude, activity.location_latitude)
      if(Participate.where("user_id = ? and activity_id = ?", user_id, activity.id))
        activity.acceptable = TRUE
      end

    end
    @activities = @activities.sort_by {|activity| activity[:distance]}
    render json: @activities
  end

  # GET filter/activities
  # 过滤活动列表
  # @param user_id
  # @param sponsor_id  发起者
  # @param participant_id  参加者
  # @param longitude 经度
  # @param latitude  纬度
  def filter
    user_id = params['user']
    sponsor_id = params['sponsor']
    participant_id = params['participant']
    longitude = params['longitude'].to_d
    latitude = params['latitude'].to_d

    if sponsor_id != nil && sponsor_id != ''
      @activities = Activity.where(["user_id = ?", sponsor_id])
    elsif participant_id != nil && participant_id != ''
      @activities = Activity.joins(:participates).where(["participates.user_id = ?", participant_id])
    else
      @activities = Activity.all
    end

    @activities.each do |activity|
      activity.distance = gps2m(longitude, latitude, activity.location_longitude, activity.location_latitude)
    end
    @activities = @activities.sort_by {|activity| activity[:distance]}

    render json: @activities
  end


  # GET activity/participate
  # 参加活动
  # @param user_id  参加活动用户ID
  # @param activity_id  加入活动ID
  def participate
    user_id = params['user']
    activity_id = params['activity_id']

    user = User.find(user_id)
    activity = Activity.find(activity_id)

    if user != nil && activity != nil
      participate = Participate.create(:user => user,
                                       :activity => activity)
      participate.save
    end
    render json:participate

  end

  # GET /activities/1
  # GET /activities/1.json
  # @param user_id
  # @param longitude 经度
  # @param latitude  纬度
  # 活动详细信息
  def show
    user_id = params['user_id'].to_i
    longitude = params['longitude'].to_d
    latitude = params['latitude'].to_d
    @activity.distance = gps2m(longitude, latitude, @activity.location_longitude, @activity.location_latitude)
    if(Participate.where("user_id = ? and activity_id = ?", user_id, @activity.id))
      @activity.acceptable = FALSE
    end
    render json: @activity
  end

  # POST /activities
  # POST /activities.json

  # 创建活动
  def create
    # @activity = Activity.new(activity_params)

    @activity = Activity.new(:description => params['description'],
                             :start_time => params['start_time'],
                             :end_time => params['end_time'],
                             :location => params['location'],
                             :location_latitude => params['latitude'],
                             :location_longitude => params['longitude'],
                             :title => params['title'],
                             :acceptable => FALSE
    )

    user = User.find(params[:user_id])
    @activity.user = user

    if @activity.save
      render json: @activity, status: :created, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  # 更新活动

  def update
    @activity = Activity.find(params[:id])

    if @activity.update(activity_params)
      head :no_content
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  # 删除活动
  def destroy
    @activity.destroy

    head :no_content
  end

  private

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      puts :activity
      params.require(:activity).permit(:title, :description, :start_time, :location_longitude, :location_latitude, :user_id)
    end


    def gps2m(lat_a, lng_a, lat_b, lng_b)

      puts '=====start====='
      puts lat_a
      puts lat_b
      puts lng_a
      puts lng_b

      radLat1 = lat_a * Math::PI / 180.0;
      radLat2 = lat_b * Math::PI / 180.0;
      a = radLat1 - radLat2;
      b = (lng_a - lng_b) * Math::PI / 180.0;
      s = 2 * Math.asin(Math.sqrt(Math.sin(a / 2)**2 + Math.cos(radLat1) * Math.cos(radLat2)* Math.sin(b / 2)**2));
      s = s * EARTH_RADIUS;
      s = (s * 10000).round / 10000;
      return s
    end
  end

