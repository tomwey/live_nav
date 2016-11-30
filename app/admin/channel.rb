ActiveAdmin.register Channel do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :intro, :image, :live_url, :sort, :opened, { node_ids: [] }
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
  
  actions
  
end

form do |f|
  f.inputs do
    f.input :name
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
