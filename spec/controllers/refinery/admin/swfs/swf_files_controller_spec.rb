require 'spec_helper'

describe Refinery::Swfs::Admin::SwfFilesController do
  render_views
  before do
    @user = Refinery::User.create!(:username => 'admin@admin.com',
                                   :email => 'admin@admin.com',
                                   :password => 'admin@admin.com',
                                   :password_confirmation => 'admin@admin.com')
    @user.create_first
    sign_in @user
  end

  describe 'delete swf file' do
    before do
      @swf = FactoryGirl.build(:swf, :use_shared => false)
      @swf_file = FactoryGirl.create(:swf_file, :external_url => 'url', :use_external => true)
      @swf.swf_files << @video_file
      @swf.save!
    end

    it 'should delete swf_file' do
      post :destroy, :id => @swf_file.id
      response.status.should redirect_to(refinery.edit_swfs_admin_swf_path(@swf))
      ::Refinery::Swfs::SwfFile.count.should == 0
    end

  end

end
