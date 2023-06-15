require 'uri'
require 'net/http'
require 'json'

def request(url_requested)
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '5f4b1b36-5bcd-4c49-     f578-75a752af8fd5'
    response = http.request(request)
    return JSON.parse(response.body)
end

data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=svYmaC54bVI7ZfdNVBiGCgf95EjH0RueHqEhePyW')

#print data
puts()
photos = data["photos"].map{|x| x['img_src']}
#print photos
html = "<html> \n <head> \n </head> \n <body> \n <ul> \n"
photos.each do |photo|
  html += "<li> <img src=\"#{photo}\"> </li> \n"
end
html += "</ul>\n</body>\n</html>"    #+=añadiendo a sí mismo

File.write('nasaaaa.html', html)

def photos_count(data)
  cameras = data["photos"].map{|x| x['camera']['name']}
  #puts cameras
  nuevo_hash=Hash.new(0)
  cameras.each do |camera|
    nuevo_hash[camera] += 1
  end
  puts nuevo_hash
end
  
photos_count(data)