class RestaurantsController < ApplicationController
  require 'httparty'

  def search
  end

  def index
    api_key = ENV['HOTPEPPER_API']
    lat = params[:lat]
    lng = params[:lng]
    url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{api_key}&lat=#{lat}&lng=#{lng}&format=json"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)
    @shops = data['results']['shop']
  end

  def show
  end

  def create
  end
end
