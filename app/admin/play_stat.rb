ActiveAdmin.register PlayStat do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

actions :all, except: [:new, :create, :edit, :update]


index do
  selectable_column
  column('ID', :id)
  column 'Media信息', sortable: false do |stat|
    img = stat.playable ? image_tag(stat.playable.image.url(:small)) : ''
    p = stat.playable ? "#{stat.playable_type_info}#{stat.playable.name}" : ''
    div do
      img + content_tag(:p, p)
    end
  end
  column :device_model, sortable: false
  column :udid, sortable: false
  column :platform, sortable: false
  column :os_version, sortable: false
  column :app_version, sortable: false
  column :lang_country, sortable: false
  column :network_type, sortable: false
  column :is_broken, sortable: false
  column :created_at
  
  actions
end

end
