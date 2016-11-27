module API
  module V1
    class ChannelsAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :channels, desc: '电视频道接口' do
        desc "获取频道列表"
        params do 
          optional :node_id, type: Integer, desc: '频道节点ID，如果不传该参数，默认会获取所有的频道' 
          use :pagination
        end
        get do
          
          if params[:node_id]
            @node = Node.find_by(nid: params[:node_id])
            if @node.blank?
              return render_error(4004, '不存在的频道类别')
            end
            @channels = @node.channels.opened.sorted
          else
            @channels = Channel.opened.sorted
          end
          
          if params[:page]
            @channels = @channels.paginate page: params[:page], per_page: page_size
          end
          
          render_json(@channels, API::V1::Entities::Channel)
        end # end get list
      end # end resource
      
    end
  end
end