module Refinery
  module Swfs
    module Admin
      class SwfFilesController < ::Refinery::AdminController

        def destroy
          @swf_file = SwfFile.find(params[:id])
          @swf = @swf_file.swf
          @swf_file.destroy
          redirect_to refinery.edit_swf_admin_swf_path(@swf), :notice => "#{@swf_file.file_name} was successfully removed."
        end

      end
    end
  end
end
