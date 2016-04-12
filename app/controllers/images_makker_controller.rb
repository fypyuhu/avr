

class ImagesMakkerController < ApplicationController
  require 'imgkit'
#  require 'tts'

  require 'open-uri'
  require 'uri'
  @@user_agent  = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.68 Safari/534.24"
  @@referer     = "http://translate.google.com/"


  def heading
    @h = params['h']

  end

  def paragraph
    @h = params['h']
    @p = params['p']


  end

  def create
    createSlide("Hellow World","Welcome to the AVR. This is me Usama. It is Test Video. This is 4th line. ",2,1)
  end




  def createSlide h , p,videoNumber,slideNumber


    createHeading h,10,videoNumber,slideNumber
    createLines h,p,10,videoNumber,slideNumber

   concatenateVideo(creatsNameArrayofSlideVideo(toLineArray(p).count()),videoNumber,slideNumber);
  #  concatenateVideo(["hb.mp4","h.mp4","hb.mp4"],videoNumber,slideNumber);

  end


  def createHeading h , n=10,videoNumber,slideNumber

    i= 0;
    num = n

    while(num>0)
      headingImage(h , num,i,n,nil,videoNumber,slideNumber)
      i = i + 1;
      num = num - 1
    end
    headingImage(h , num-2,i-1,n,true,videoNumber,slideNumber)


    createVideoForSeriesOfImage( videoNumber,slideNumber,"h")

    createVoice h,1,videoNumber,slideNumber,"h.mp3"
    createALoopVideo "h",videoNumber,slideNumber

  end

  def createLines h,p, n=10,videoNumber,slideNumber
    preLines = [];
    lines = toLineArray p

    size = lines.size();
    (0...size).each do |i|
      createLine h,preLines,lines[i] ,i, n,videoNumber,slideNumber


      preLines.append(lines[i])


      createVoice lines[i],1,videoNumber,slideNumber,"l"+i.to_s+"l.mp3"
      createALoopVideo "l"+i.to_s+"l",videoNumber,slideNumber

    end

  end
  def createLine h,lines,nline ,lineNumber, n=10,videoNumber,slideNumber

    i= 0;
    num = n
    list = lines.deep_dup
    list.append(nline)
    while(num>0)
      itemImage(h,lines ,nline, num,i,n,nil,videoNumber,slideNumber,lineNumber)
      i = i + 1;
      num = num - 1
    end
    createVideoForSeriesOfImage( videoNumber,slideNumber,"l"+lineNumber.to_s+"l")

    listImage h,list,videoNumber,slideNumber,lineNumber


  end


  def headingImage (h ,num,i , total,last=nil,videoNumber,slideNumber)
    html = headingHtml h,num,i,total

    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"

    name = "/h"+(i).to_s+".png"

    name = "/h.png" if last !=nil
    createImage(html,path,name)


  end

  def itemImage (h,lines,newLine,num,i , total,last=nil,videoNumber,slideNumber,lineNumber)


    html = listItemHTML h, lines,newLine,num,i,total


    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"

    name = "l"+lineNumber.to_s+"l"+(i).to_s+".png"


    createImage(html,path,name)


  end
  def listImage h,lines,videoNumber,slideNumber,lineNumber
    html = listItemHTMLFull h,lines
    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"
    name = "l"+lineNumber.to_s+"l.png"

    createImage(html,path,name)

  end


  private def headingHtml h ,num,i , total
  html = "
    <html>
    <head></head>
    <body style=' height:300px'>

      <h1  style='padding-top:"+num.to_s+";opacity:0."+((i)).to_s+"' >

        "+h+"

      </h1>

    </body>
    </html>

"

end

  def listItemHTMLFull h,lines
    str = "<ul>"
    lines.each do |line|
      str += "<li>"+line.to_s+"</li>"
    end
    str += "</ul>"

    headWithListHtml h,str
  end




  def listItemAppendHTML prelinesArray,newItemHtmlt

    str = "<ul>"
    prelinesArray.each do |line|
      str += "<li>"+line.to_s+"</li>"
    end
      str += newItemHtmlt
    str += "</ul>"
  end


  def listItemHTML h,lines,newLine,num,i,total


      nlineHTML = newItemHtml newLine,num,i
      lineHTML = listItemAppendHTML lines , nlineHTML

      headWithListHtml h,lineHTML

  end
  def newItemHtml line,num,i
    html =  "<li style='padding-top:"+num.to_s+";opacity:0."+((i)).to_s+"' >

        "+line.to_s+"

      </li>
    "

  end

  def headWithListHtml  h , listHtml
  html = "
    <html>
    <head></head>
    <body style=' height:300px'>

      <h1>

        "+h+"

      </h1>
      "+listHtml+"
    </body>
    </html>
  "
end



  private def createImage(html,path,name,width = 400)
    @kit = IMGKit.new(html,:quality=>'50',:width =>width)
    @kit.to_img(:png)

    FileUtils.mkdir_p(path) unless File.directory?(path)

    @kit.to_file(path + name)
  end
  def createVideoForSeriesOfImage videoNumber,slideNumber,name
    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"

    command = "ffmpeg -r 10 -f image2 -s 1920x1080 -start_number 1 -i "+path+name+"%d.png -vframes 1000 -vcodec libx264 -crf 25  -pix_fmt yuv420p "+path+name+".mp4 -y"
    system command

  end

  def createALoopVideo name, videoNumber,slideNumber
    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"

    command = "ffmpeg -r 10 -f image2 -s 1920x1080 -loop 1 -i "+path+name+".png"+" -i "+path+name+".mp3 -shortest -c:v libx264 -c:a copy "+path+name+"b.mp4 -y"

    system command
  end

  private def concatenateVideo namesOfFiles, videoNumber,slideNumber

    writeToFile namesOfFiles, videoNumber,slideNumber

    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"


    command = "ffmpeg -f concat -i "+path+"mylist.txt -c copy "+path+"output.mp4 -y";


    system command

    command = "ffmpeg -i "+path+"output.mp4 -c:v libx264 -ar 22050 -crf 0 "+path+"ouput.flv -y"

    system command



  end




  private def writeToFile arr, videoNumber,slideNumber
    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"

    name = "mylist.txt"

    out_file = File.new(path+name, "w")
    arr.each do |name|
      out_file.puts("file '"+name.to_s+"'")
    end
    out_file.close
  end

  private def toLineArray lines
    list = lines.split(". ")



  end



  def createVoice text,voiceNumber, videoNumber,slideNumber,filename
    url = to_url text
    content = open(url, "User-Agent" => @@user_agent, "Referer" => @@referer).read

    path = "#{Rails.root}/raw/video/"+videoNumber.to_s+"/slide/"+slideNumber.to_s+"/"



    File.open(path+filename, "wb") do |f|
      f.puts content
    end


  end
  def to_url text
    base = "https://translate.google.com/translate_tts?ie=UTF-8&q=#{URI.escape text}&tl=en-TW&client=tw-ob"

  end
  def creatsNameArrayofSlideVideo size
    arr =  [];
    arr.append("hb.mp4")

    arr.append("h.mp4")
    arr.append("hb.mp4")

    (0...size).each do |i|
      arr.append("l"+i.to_s+"l.mp4")
      arr.append("l"+i.to_s+"lb.mp4")

    end
    return arr
  end

end
