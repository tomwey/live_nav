module API
  module V1
    class ChannelsAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :channels, desc: '获取频道列表' do
        desc "获取频道列表"
        params do 
          use :pagination
        end
        get do
          @channels = Channel.opened.sorted
          
          if params[:page]
            @channels = @channels.paginate page: params[:page], per_page: page_size
          end
          
          render_json(@channels, API::V1::Entities::Channel)
        end # end get list
      end # end resource
      
    end
  end
end