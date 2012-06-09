module Refinery
  module Swfs
    module Admin
      class SwfsController < ::Refinery::AdminController

        crudify :'refinery/swfs/swf',
                :title_attribute => 'title',
                :xhr_paging => true,
                :order => 'position ASC',
                :sortable => true

        before_filter :set_embedded, :only => [:new, :create]

        def show
          @swf = Swf.find(params[:id])
        end

        def new
          @swf = Swf.new
          @swf.swf_files.build
        end

        def insert
          search_all_swfs if searching?
          find_all_swfs
          paginate_swfs
        end

        def append_to_wym
          @swf = Swf.find(params[:swf_id])
          params['swf'].each do |key, value|
            @swf.config[key.to_sym] = value
          end
          @html_for_wym = @swf.to_html
        end

        def dialog_preview
          @swf = Swf.find(params[:id].delete('swf_'))
          w, h = @swf.config[:width], @swf.config[:height]
          @swf.config[:width], @swf.config[:height] = 300, 200
          @preview_html = @swf.to_html
          @swf.config[:width], @swf.config[:height] = w, h
          @embedded = true if @swf.use_shared
        end

        private

        def paginate_videos
          @swf = @swf.paginate(:page => params[:page], :per_page => Swf.per_page(true))
        end

        def set_embedded
          @embedded = true if params['embedded']
        end

      end
    end
  end
end
