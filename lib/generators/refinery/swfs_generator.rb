module Refinery
  class SwfsGenerator < Rails::Generators::Base
    source_root File.expand_path('../swfs/templates', __FILE__)

    def rake_db
      rake("refinery_swfs:install:migrations")
    end

    def generate_swfs_initializer
      template "config/initializers/refinery/swfs.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "swfs.rb")
    end

    def generate_swfjs_loader
      template "assets/javascripts/swfjs_loader.js", File.join(destination_root, "app", "assets", "javascripts", "swfjs_loader.js")
    end

  end
end
