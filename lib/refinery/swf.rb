require 'refinerycms-core'
require 'dragonfly'
require 'rack/cache'


module Refinery
  autoload :SwfsGenerator, 'generators/refinery/swfs_generator'

  module Swfs
    require 'refinery/swfs/engine'
    require 'refinery/swfs/configuration'
    autoload :Dragonfly, 'refinery/swfs/dragonfly'
    autoload :Validators, 'refinery/swfs/validators'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end

