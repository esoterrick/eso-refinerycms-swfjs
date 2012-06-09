require 'dragonfly'

module Refinery
  module Swfs
    module Dragonfly

      class << self
        def setup!
          app_swfs = ::Dragonfly[:refinery_swfs]

          app_swfs.define_macro(::Refinery::Swfs::SwfFile, :swf_accessor)

          app_swfs.analyser.register(::Dragonfly::Analysis::FileCommandAnalyser)
          app_swfs.content_disposition = :attachment
        end

        def configure!
          app_swfs = ::Dragonfly[:refinery_swfs]
          app_swfs.configure_with(:rails) do |c|
            #c.datastore = ::Dragonfly::DataStorage::MongoDataStore.new(:db => MongoMapper.database)
            c.datastore.root_path = Refinery::Swfs.datastore_root_path
            c.url_format = Refinery::Swfs.dragonfly_url_format
            c.secret = Refinery::Swfs.dragonfly_secret
          end

          if ::Refinery::Swfs.s3_backend
            app_swfs.datastore = ::Dragonfly::DataStorage::S3DataStore.new
            app_swfs.datastore.configure do |s3|
              s3.bucket_name = Refinery::Swfs.s3_bucket_name
              s3.access_key_id = Refinery::Swfs.s3_access_key_id
              s3.secret_access_key = Refinery::Swfs.s3_secret_access_key
              # S3 Region otherwise defaults to 'us-east-1'
              s3.region = Refinery::Swfs.s3_region if Refinery::Swfs.s3_region
            end
          end
        end

        def attach!(app)
          ### Extend active record ###
          app.config.middleware.insert_before Refinery::Swfs.dragonfly_insert_before,
                                              'Dragonfly::Middleware', :refinery_swfs

          app.config.middleware.insert_before 'Dragonfly::Middleware', 'Rack::Cache', {
              :verbose     => Rails.env.development?,
              :metastore   => "file:#{URI.encode(Rails.root.join('tmp', 'dragonfly', 'cache', 'meta').to_s)}",
              :entitystore => "file:#{URI.encode(Rails.root.join('tmp', 'dragonfly', 'cache', 'body').to_s)}"
          }
        end
      end

    end
  end
end
