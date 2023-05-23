class RestaurantsController < ApplicationController
  require 'httparty'

  def search
  end

  def index
    # hotpepper_api呼び出し
    api_key = ENV['HOTPEPPER_API']
    lat = params[:lat]
    lng = params[:lng]
    range = params[:range]
    url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{api_key}&lat=#{lat}&lng=#{lng}&range=#{range}&format=json"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    # ページング
    @shops = Kaminari.paginate_array(data['results']['shop']).page(params[:page]).per(10)
  end

  def show
  end

  def create
  end
end
