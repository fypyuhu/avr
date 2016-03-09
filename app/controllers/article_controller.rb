class ArticleController < ApplicationController
  before_action :authenticate_user!
  layout "userpanel"


  attr_reader   'rubygems'
  require 'nokogiri'
  require 'open-uri'


  def index

  end
  def scrap

    url = params[:url]

    page = Nokogiri::HTML(open(url).read)
@arr = []

    for i in 0...page.css('h3').count

      @arr <<  '{"h3":"'+ page.css('h3')[i].text.to_s + '"}'

    end
    @hash = {
        'url' => url,
        'class' =>  page.class.to_s,
        'title' => page.css('title').text,
        'h1' => page.css('h1').text,
        'h3' => @arr.as_json

    }

    render :json =>         @hash.as_json


  end
end
