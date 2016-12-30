class PlayStat < ActiveRecord::Base
  def playable
    if playable_type.to_s == '1'
      # 电视
      Channel.find_by(chn_id: playable_id)
    elsif playable_type.to_s == '2'
      # 直播
      LiveStream.find_by(sid: playable_id)
    elsif playable_type.to_s == '3'
      # 视频
      Video.find_by(vid: playable_id)
    else
      nil
    end
  end
  
  def playable_type_info
    if playable_type.to_s == '1'
      # 电视
      "【电视】"
    elsif playable_type.to_s == '2'
      # 直播
      "【直播】"
    elsif playable_type.to_s == '3'
      # 视频
      "【视频】"
    else
      nil
    end
  end
end
