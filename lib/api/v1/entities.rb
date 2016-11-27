module API
  module V1
    module Entities
      class Base < Grape::Entity
        format_with(:null) { |v| v.blank? ? "" : v }
        format_with(:chinese_date) { |v| v.blank? ? "" : v.strftime('%Y-%m-%d') }
        format_with(:chinese_datetime) { |v| v.blank? ? "" : v.strftime('%Y-%m-%d %H:%M:%S') }
        format_with(:money_format) { |v| v.blank? ? 0 : ('%.2f' % v).to_f }
        expose :id
        # expose :created_at, format_with: :chinese_datetime
      end # end Base
      
      # 版本信息
      class AppVersion < Base
        expose :version
        expose :app_download_url do |model, opts|
          if model.file
            model.file.url
          else
            ''
          end
        end
        expose :must_upgrade
        expose :link do |model, opts|
          model.version_summary_url
        end
      end
      
      # 收货地址
      class Shipment < Base
        expose :name
        expose :hack_mobile, as: :mobile
        expose :address
        expose :is_current do |model, opts|
          model.id == model.user.try(:current_shipment_id)
        end
      end
      
      # 用户基本信息
      class UserProfile < Base
        expose :uid, format_with: :null
        expose :mobile, format_with: :null
        expose :nickname do |model, opts|
          model.nickname || model.hack_mobile
        end
        expose :avatar do |model, opts|
          model.avatar.blank? ? "" : model.avatar_url(:large)
        end
        expose :nb_code, as: :invite_code
        expose :bean
        expose :balance
        expose :current_shipment, as: :shipment, using: API::V1::Entities::Shipment, if: proc { |u| u.current_shipment_id.present? }
        # expose :wifi_length
        expose :qrcode_url
      end
      
      # 用户详情
      class User < UserProfile
        expose :private_token, as: :token, format_with: :null
      end
      
      # 频道节点
      class Node < Base
        unexpose :id
        expose :nid, as: :id, format_with: :null
        expose :name, format_with: :null
      end
      
      # 频道列表
      class Channel < Base
        expose :chn_id, :name, :live_url
        expose :intro, format_with: :null
        expose :image do |model, opts|
          model.image.blank? ? '' : model.image.url(:thumb)
        end
      end
      
      # 订单
      class Order < Base
        expose :order_no
        expose :product_title, as: :title
        expose :product_small_image, as: :image
        expose :quantity
        expose :product_price, as: :price
        expose :total_fee
        expose :state_info, as: :state
        expose :created_at, as: :time, format_with: :chinese_datetime
      end
      
      # 消息
      class Message < Base
        expose :title do |model, opts|
          model.title || '系统公告'
        end#, format_with: :null
        expose :content, as: :body
        expose :created_at, format_with: :chinese_datetime
      end
    
    end
  end
end
