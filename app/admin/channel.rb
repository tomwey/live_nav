ActiveAdmin.register Channel do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :intro, :image, :live_url, :sort, :opened
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
  column :intro, sortable: false
  column :sort
  column :opened
  column :created_at
  
  actions
  
end


end
