require 'rest-client'
require 'digest'

module Douyu
  class Room
    def self.fetch(room_id)
      time = Time.now.to_i
      
      auth = Digest::MD5.hexdigest("lapi/live/thirdPart/getPlay/#{room_id}?aid=hbtv&time=#{time}rRrJQ10J8cnGmAz2")
      
      url = "http://coapi.douyucdn.cn/lapi/live/thirdPart/getPlay/#{room_id}?aid=hbtv&time=#{time}&auth=#{auth}"
      puts url
      
      RestClient.get url, { aid: 'hbtv', time: time, auth: auth, accept: :json } do |resp|
        puts resp
        puts '---------------------------------------------'
      end
      
    end
  end
end

%w(321987 265593 683954 1339207 1235257 479171 1243456 8303 966276 542173).each do |room_id|
  Douyu::Room.fetch(room_id)
end