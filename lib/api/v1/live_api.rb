module API
  module V1
    class LiveAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :live, desc: '直播相关接口' do
        desc "获取直播列表"
        params do
          optional :filter, type: String, desc: '数据过滤用，保留参数，做数据过滤用' 
          use :pagination
        end
        get :list do
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