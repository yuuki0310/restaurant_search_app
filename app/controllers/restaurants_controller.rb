class RestaurantsController < ApplicationController
  require "httparty"

  def search
  end

  def index
    if params[:lat].empty? || params[:lng].empty?
      # inputにlatlngが入空の時
      redirect_to root_path
    else
      # hotpepper_api呼び出し
      api_key = ENV["HOTPEPPER_API"]
      url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{api_key}&lat=#{params[:lat]}&lng=#{params[:lng]}&range=#{params[:range]}&count=70&format=json"
      response = HTTParty.get(url)
      data = JSON.parse(response.body)
  
      # ページング
      @shops = Kaminari.paginate_array(data["results"]["shop"]).page(params[:page]).per(10)
  
      # 検索結果の地図に描写する際のパラメーターをjsonで渡す
      @shop_map_informations = data["results"]["shop"].map do |shop|
        {
          "name" => shop["name"],
          "lat" => shop["lat"],
          "lng" => shop["lng"],
          "img" => shop["photo"]["pc"]["s"],
          "id" => shop["id"],
        }
      end
      gon.search_lat = params[:lat]
      gon.search_lng = params[:lng]
      gon.shop_map_informations_json = @shop_map_informations.to_json
    end
  end

  def show
    # hotpepper_api呼び出し
    api_key = ENV["HOTPEPPER_API"]
    url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{api_key}&id=#{params[:id]}&format=json"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    @shop = data["results"]["shop"][0]
  end
end
