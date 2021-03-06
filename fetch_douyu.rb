require 'rest-client'
require 'digest'

module Douyu
  class Room
    def self.fetch_room_info(room_id)
      time = Time.now.to_i
      
      auth = Digest::MD5.hexdigest("lapi/live/thirdPart/getPlay/#{room_id}?aid=hbtv&time=#{time}rRrJQ10J8cnGmAz2")
      
      url = "http://coapi.douyucdn.cn/lapi/live/thirdPart/getPlay/#{room_id}?aid=hbtv&time=#{time}&auth=#{auth}"
      puts url
      
      RestClient.get url, { aid: 'hbtv', time: time, auth: auth, accept: :json } do |resp|
        # puts JSON.parse(resp)
        # puts '---------------------------------------------'
        puts resp
      end
      
    end
    
    # 获取正在直播的房间列表
    def self.fetch_room_list
      time = Time.now.to_i
      
      auth = Digest::MD5.hexdigest("api/thirdPart/live?aid=hbtv&limit=10&offset=0&time=#{time}rRrJQ10J8cnGmAz2")
      
      url = "http://coapi.douyucdn.cn/api/thirdPart/live?aid=hbtv&time=#{time}&auth=#{auth}&limit=10&offset=0"
      puts url
      
      RestClient.get url, { aid: 'hbtv', time: time, auth: auth, accept: :json } do |resp|
        puts JSON.parse(resp)["data"]
        # puts '---------------------------------------------'
      end
    end
    
  end
end

# %w(321987 265593 683954 1339207 1235257 479171 1243456 8303 966276 542173).each do |room_id|
#   Douyu::Room.fetch_room_info(room_id)
# end
# %w(1235257 8303 671133 1534189 566952 1649096 1266438 295415 588086 310331 1467077 997889 464311 243850 1692795 692897 1462051 129901 225232 99039 437736 149222).each do |room_id|
#   Douyu::Room.fetch_room_info(room_id)
# end

%w(1235257 479171 1243456 8303 1534189 566952 1649096 1266438 588086 310331 1467077 1692795 692897 1462051 437736 149222).each do |room_id|
  Douyu::Room.fetch_room_info(room_id)
end

# Douyu::Room.fetch_room_list
# Douyu::Room.fetch_room_info(442078)
