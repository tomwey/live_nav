ActiveAdmin.register Playlist do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# t.string :name, null: false
# t.datetime :started_at, null: false, index: true
# t.datetime :ended_at, null: false
# t.integer :pl_id
# t.string :vod_url

permit_params :name, :started_at, :ended_at, :vod_url, :channel_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do
  selectable_column
  column('ID',:id) { |playlist| link_to playlist.id, cpanel_playlist_path(playlist) }
  column(:name, sortable: false) { |playlist| link_to playlist.name, cpanel_playlist_path(playlist) }
  # column :image, sortable: false do |channel|
  #   if channel.image.blank?
  #     ''
  #   else
  #     image_tag channel.image.url(:small)
  #   end
  # end
  column '所属频道' do |playlist|
    playlist.channel.name
  end
  column :started_at
  column :ended_at
  column :created_at
  
  actions
  
end

form do |f|
  f.inputs do
    f.input :name
    f.input :channel_id, as: :select, collection: Channel.opened.map { |channel| [channel.name, channel.id] }, prompt: '-- 选择频道 --'
    f.input :started_at, as: :string, placeholder: '2016-10-10 10:29', hint: '格式为：2016-10-10 10:29'
    f.input :ended_at, as: :string, placeholder: '2016-10-10 10:29', hint: '格式为：2016-10-10 10:29'
    f.input :vod_url, placeholder: 'http://www.deyiwifi.com/test.mp4', hint: '节目回看地址'
  end
  actions
end


end
