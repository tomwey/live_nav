ActiveAdmin.register Channel do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :intro, :image, :live_url, :py_name, :sort, :opened, { node_ids: [] }
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
  column('ID',:id) { |channel| link_to channel.id, cpanel_channel_path(channel) }
  column(:name, sortable: false) { |channel| link_to channel.name, cpanel_channel_path(channel) }
  column :image, sortable: false do |channel|
    if channel.image.blank?
      ''
    else
      image_tag channel.image.url(:small)
    end
  end
  column '所属节点' do |channel|
    raw("#{channel.nodes.map { |node| node.name }.join('<br>')}")
  end
  column :intro, sortable: false
  column :sort
  column :opened
  column :created_at
  
  actions defaults: false do |channel|
    item '查看', cpanel_channel_path(channel)
    item '编辑', edit_cpanel_channel_path(channel)
    item '删除', cpanel_channel_path(channel), method: :delete, data: { confirm: '确定吗？' }
    item '导入节目', add_playlists_cpanel_channel_path(channel), method: :post
  end
  
end

member_action :add_playlists, method: :post do
  resource.add_playlists!
  redirect_to collection_path, notice: "导入成功"
end

form do |f|
  f.inputs do
    f.input :name
    f.input :py_name
    f.input :image
    f.input :live_url
    f.input :nodes, as: :check_boxes
    f.input :intro
    f.input :sort
    f.input :opened, as: :boolean
  end
  actions
end


end
