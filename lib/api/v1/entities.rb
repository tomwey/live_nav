module API
  module V1
    module Entities
      class Base < Grape::Entity
        format_with(:null) { |v| v.blank? ? "" : v }
        format_with(:chinese_date) { |v| v.blank? ? "" : v.strftime('%Y-%m-%d') }
        format_with(:chinese_datetime) { |v| v.blank? ? "" : v.strftime('%Y-%m-%d %H:%M:%S') }
        format_with(:chinese_time) { |v| v.blank? ? "" : v.strftime('%H:%M') }
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
        # expose :nb_code, as: :invite_code
        # expose :bean
        # expose :balance
        # expose :current_shipment, as: :shipment, using: API::V1::Entities::Shipment, if: proc { |u| u.current_shipment_id.present? }
        # # expose :wifi_length
        # expose :qrcode_url
      end
      
      # 用户详情
      class User < UserProfile
        expose :private_token, as: :token, format_with: :null
      end
      
      # 电视频道节点
      class Node < Base
        unexpose :id
        expose :nid, as: :id, format_with: :null
        expose :name, format_with: :null
      end
      
      # 电视频道
      class Channel < Base
        expose :chn_id, as: :id
        expose :name, :live_url
        expose :view_count
        # expose :intro, format_with: :null
        expose :title do |model, opts|
          model.current_playlist.try(:name) || ''
        end
        expose :image do |model, opts|
          model.image.blank? ? '' : model.image.url(:thumb)
        end
      end
      
      # 频道节目
      class Playlist < Base
        expose :pl_id, as: :id
        expose :name
        expose :started_at, as: :start_time, format_with: :chinese_time
        expose :ended_at, as: :end_time, format_with: :chinese_time
        expose :vod_url, as: :playback_url, format_with: :null
        expose :appointed do |model, opts|
          if opts
            if opts[:user]
              user = opts[:user]
              user.appointed?(model)
            else
              false
            end
          else
            false
          end
        end
        expose :current do |model, opts|
          if opts && opts[:time]
            if opts[:time] >= model.started_at and opts[:time] < model.ended_at
              true
            else
              false
            end
          else
            false
          end
        end
      end
      
      class ChannelDetail < Channel
        unexpose :title
        expose :favorited do |model, opts|
          opts = opts[:opts]
          if opts
            user = opts[:user]
            if user
              user.favorited?(model)
            else
              false
            end
          else
            false
          end
        end
        # Destinations::DestinationResponseEntity.represent trip.destinations, options.merge(custom_field_name: custom_field_value)
        # expose :today_playlists, using: API::V1::Entities::Playlist do |model, opts|
        #   model.playlists_for_offset(0)
        # end
        expose :today_playlists do |model, opts|
          time = Time.zone.now
          user = if opts
            if opts[:opts]
              opts[:opts][:user]
            else
              nil
            end
          else
            nil
          end
          API::V1::Entities::Playlist.represent model.playlists_for_offset(0), options.merge(time: time, user: user)
        end
      end
      
      # 直播
      class LiveStream < Base
        expose :sid, as: :id
        expose :name, :live_url
        expose :view_count
        # expose :intro, format_with: :null
        expose :image do |model, opts|
          model.image.blank? ? '' : model.image.url(:thumb)
        end
      end
      
      class LiveStreamDetail < LiveStream
        expose :favorited do |model, opts|
          opts = opts[:opts]
          if opts
            user = opts[:user]
            if user
              user.favorited?(model)
            else
              false
            end
          else
            false
          end
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
