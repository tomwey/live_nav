require 'rest-client'
require 'digest'
require 'json'
# require 'live_stream.rb'

module YaoBo
  class Live 
    def self.fetch_room
      app_id = 'hbcbc'
      app_secret = 'a853f3bf7a12d6e40ae0735fd3c7a729'
      rand = SecureRandom.hex[0..9]
      time = Time.now.to_i
      
      app_token = Digest::MD5.hexdigest(app_id + '_' + rand + '_' + time.to_s + '_' + app_secret)
      
      offset = 0
      url = "http://open.hifun.mobi/live/getRecommonds?appid=#{app_id}&apptoken=#{app_token}&rand=#{rand}&time=#{time}&offset=#{offset}"
      puts url
      RestClient.get url, {content_type: :json, accept: :json} do |resp|
        # puts JSON.parse(resp)
        # puts '---------------------------------------------'
        # puts resp
        result = JSON.parse(resp)
        if result['code'] == 0
          if result['data'] && result['data']['lives']
            result['data']['lives'].each do |item|
              obj = item['live']
              # puts obj
              # puts '--------------'
              if obj
                room_id = obj['liveid']
                ls = LiveStream.find_by(source_room_id: room_id)
                if ls
                  ls.online = obj['status'] == '1' ? true : false
                  ls.save!
                else
                  ls = LiveStream.create(name: obj['title'], 
                                         remote_image_url: obj['cover'], 
                                         live_url: obj['flv'],
                                         source_name: '要播',
                                         source_room_id: obj['liveid'],
                                         online: obj['status'] == '1' ? true : false)
                end
              end
            end
          end
        else
          
        end
        
      end
    end
  end
end

YaoBo::Live.fetch_room