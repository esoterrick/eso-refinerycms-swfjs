require 'dragonfly'

module Refinery
  module Swfs
    class SwfFile < Refinery::Core::BaseModel

      self.table_name = 'refinery_swf_files'
      acts_as_indexed :fields => [:file_name, :file_ext]
      attr_accessible :file, :file_mime_type, :position, :use_external, :external_url
      belongs_to :swf

      MIME_TYPES = {'.swf' => 'swf'}

      ############################ Dragonfly
      ::Refinery::Swfs::Dragonfly.setup!
      swf_accessor :file

      delegate :ext, :size, :mime_type, :url,
               :to        => :file,
               :allow_nil => true

      #######################################

      ########################### Validations
      validates :file, :presence => true, :unless => :use_external?
      validates :mime_type, :inclusion => { :in =>  Refinery::Swfs.config[:whitelisted_mime_types],
                                            :message => "Wrong file mime_type" }, :if => :file_name?
      validates :external_url, :presence => true, :if => :use_external?
      #######################################

      before_save :set_mime_type
      before_update :set_mime_type

      def exist?
        use_external ? external_url.present? : file.present?
      end

      def short_info
        if use_external
           ['.link', external_url]
        else
           ['.file', file_name]
        end
      end

      private

      def set_mime_type
        if use_external
          type = external_url.scan(/\.\w+$/)
          if type.present? && MIME_TYPES.has_key?(type.first)
            self.file_mime_type = "swf/#{MIME_TYPES[type.first]}"
          else
            self.file_mime_type = 'swf/swf'
          end
        end

      end


    end
  end
end
