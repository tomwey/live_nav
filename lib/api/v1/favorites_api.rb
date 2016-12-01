module API
  module V1
    class FavoritesAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :favorites, desc: '收藏相关接口' do
        desc "我的收藏"
        params do
          requires :token, type: String, desc: '用户Token'
          use :pagination
        end
        get do
          user = authenticate!
          
          @favorites = Favorite.where(user_id: user.id).order('id desc')
          
          if params[:page]
            @favorites = @favorites.paginate page: params[:page], per_page: page_size
          end
          
          render_json(@favorites, API::V1::Entities::Favorite)
        end # end get
        
        desc "删除收藏"
        params do
          requires :token, type: String, desc: '用户Token'
          requires :ids,   type: String, desc: '需要删除的收藏id，支持多个删除，多个id之间用英文逗号分隔(,)'
        end
        post :delete do
          user = authenticate!
          
          ids = params[:ids].split(',')
          
          Favorite.where(user_id: user.id, id: ids).delete_all
          render_json_no_data
        end # end post delete
      end # end resource
      
    end
  end
end