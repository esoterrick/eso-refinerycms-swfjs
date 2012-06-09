class CreateSwfsSwfs < ActiveRecord::Migration

  def up
    create_table "refinery_swf", :force => true do |t|
      t.integer  "position"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.string   "config"
      t.string   "title"
      t.integer  "poster_id"
      t.boolean  "use_shared"
      t.text     "embed_tag"
    end
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-swfs"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/swfs/swfs"})
    end

    drop_table :refinery_swfs

  end

end
