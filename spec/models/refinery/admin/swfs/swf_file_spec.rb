require 'spec_helper'

module Refinery
  module Swfs
    describe SwfFile do
      before(:each) do
        file = File.new(File.join(Rails.root, 'spec/support/fixtures/swf.swf'))
        @swf_file = FactoryGirl.create(:swf_file, :file => file)
      end

      it 'should be invalid' do
        @swf_file.file = nil
        @swf_file.should be_invalid
      end

      it 'should be invalid again' do
        @swf_file.file = nil
        @swf_file.use_external = true
        @swf_file.should be_invalid
      end

      it 'should be valid' do
        @swf_file.should be_valid
      end

      it 'should be valid again' do
        @swf_file.file = nil
        @swf_file.use_external = true
        @swf_file.external_url = 'file.swf'
        @swf_file.should be_valid
      end

      it 'should return true when file exist' do
        @swf_file.exist?.should be_true
      end

      it 'should return false when file does not exist' do
        @swf_file.file = nil
        @swf_file.exist?.should be_false
      end

      it 'should determine mime_type from url' do
        @swf_file = SwfFile.create(:use_external => true, :external_url => 'www')
        @swf_file.file_mime_type.should == 'swf/swf'
        @swf_file.update_attributes(:external_url => 'www.site.com/swf.swf')
        @swf_file.file_mime_type.should == 'swf/swf'
      end

    end
  end
end
