ActiveAdmin.register LiveStream do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :intro, :image, :live_url, :sort, :opened, :source_name, :source_room_id
#
# or
#
index do
  selectable_column
  column('ID',:id) { |ls| link_to ls.id, cpanel_live_stream_path(ls) }
  column(:name, sortable: false) { |ls| link_to ls.name, cpanel_live_stream_path(ls) }
  column :image, sortable: false do |ls|
    if ls.image.blank?
      ''
    else
      image_tag ls.image.url(:small)
    end
  end
  column '当前直播状态', sortable: false do |ls|
    ls.online ? '直播中' : '未直播'
  end
  column :source_name, sortable: false
  column :source_room_id, sortable: false
  # column :intro, sortable: false
  column :sort
  column :opened
  column :created_at
  
  actions
  
end

form do |f|
  f.inputs do
    f.input :name
    f.input :image
    f.input :live_url
    f.input :source_name, placeholder: '直播来源，例如斗鱼，花椒等等'
    f.input :source_room_id, placeholder: '直播平台的房间ID，例如：32132'
    f.input :intro
    f.input :sort
    f.input :opened, as: :boolean
  end
  actions
end


end
