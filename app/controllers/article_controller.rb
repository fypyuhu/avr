class ArticleController < ApplicationController
 # before_action :authenticate_user!
  layout "userpanel"


  attr_reader   'rubygems'
  require 'nokogiri'
  require 'open-uri'


  def index

  end
  def scrap1

    url = params[:url]

    url = Addressable::URI.parse(url).normalize.to_s

    user_agent = "Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"

    page = Nokogiri::HTML(open(url,"User-Agent" => user_agent).read)


    @hash = {
       # 'h1' =>  toArray(page,'h1'),
       # 'h2' =>  toArray(page,'h2'),
       # 'h3' =>  toArray(page,'h3'),
       # 'h4' =>  toArray(page,'h4'),
       # 'h5' =>  toArray(page,'h5'),

       # 'p' => toArray(page,'p'),
        'img' =>toArray(page,'img','src'),
        'img2' =>toArray(page,'img','src',url),
        #'page' => page.text

    }

    render :json =>         @hash.as_json


  end
  def scrap


    url = params[:url]

    url = Addressable::URI.parse(url).normalize.to_s

    doc = Nokogiri::HTML(open(url).read)
    h1s = []
    h1 = Hash.new


   children = doc.css("body").children;

   #h1 = extract children , 'h1'


#   data = doc.css("body").children[1].css('a')[0]['name']
    @hash = {


        'h1' => extract(children , 'h1'),
        'h2' => extract(children , 'h2'),
        'h3' => extract(children , 'h3'),
        'p' =>  extract(children , 'p'),
    }

    render :json =>         @hash.as_json


  end

  # 'data' =>doc.css("div")[3].children.css("code")

  private


  def toArray page,parameter,attr = false,base=false
    data = []
    for i in 0...  page.css(parameter).count
      if(attr == false)
        data[i] = page.css(parameter)[i].text.delete("\n")

      else
        data[i] = page.css(parameter)[i].attr(attr)
        if(attr == 'src' && base != false)
          data[i] = toAbsolutePath(base,data[i])
        end
      end
    end
    data
  end

  private def toAbsolutePath base,src

    src.prepend "/"  if(src[0]!= '/' )

    base =URI.parse(base)

    unless (src.empty?)


      uri = URI.parse(src)

      unless uri.host
        uri.scheme = base.scheme
        uri.host = base.host

      end
    end
   uri.to_s
  end
private def openDoc url
  url = Addressable::URI.parse(url).normalize.to_s

  user_agent = "Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"

  doc = Nokogiri::HTML(open(url,"User-Agent" => user_agent).read)

end

 def findLevel node,rootName
   level = 0
   while( node.parent.name != rootName )
     level = level +1
     node = node.parent
   end
   level
 end
  def extract children , element
    nodes = children.css(element);

    i  = 0;
    data = []
    nodes.each do |node|
      h1 = Hash.new

      h1["text"] = node.text
      h1["lineNumber"] = node.line
#      h1["level"] = findLevel node , 'body',
      h1["name"] = element
      data[i] =h1
      i = i + 1
    end
  data
  end
end
