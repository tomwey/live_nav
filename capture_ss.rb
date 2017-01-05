require 'streamio-ffmpeg'

movie = FFMPEG::Movie.new("http://125.88.92.166:30001/PLTV/88888956/224/3221227692/1.m3u8")
puts movie.valid?