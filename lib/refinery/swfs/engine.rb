module Refinery
  module Swfs
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Swfs

      engine_name :refinery_swfs

      initializer 'attach-refinery-swfs-with-dragonfly', :after => :load_config_initializers do |app|
        ::Refinery::Swfs::Dragonfly.configure!
        ::Refinery::Swfs::Dragonfly.attach!(app)
      end

      initializer "register refinerycms_swfs plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "swfs"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.swfs_admin_swfs_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/swfs/swf',
            :title => 'title'
          }

        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Swfs)
      end
    end
  end
end
