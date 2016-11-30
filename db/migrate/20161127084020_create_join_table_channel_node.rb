class CreateJoinTableChannelNode < ActiveRecord::Migration
  def change
    create_table :channels_nodes, id: false do |t|
      # t.index [:channel_id, :node_id]
      # t.index [:node_id, :channel_id]
      t.integer :channel_id
      t.integer :node_id
    end
    add_index :channels_nodes, :channel_id
    add_index :channels_nodes, :node_id
  end
end
