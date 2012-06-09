# encoding: utf-8
require "spec_helper"
Capybara.javascript_driver = :webkit
module Refinery
  module Swfs
    describe 'Admin' do
      describe 'swfs' do

        before do
          visit refinery.new_refinery_user_session_path
          fill_in "Username", :with => 'admin@admin.com'
          fill_in "Email", :with => 'admin@admin.com'
          fill_in "Password", :with => 'admin@admin.com'
          fill_in "Password confirmation", :with => 'admin@admin.com'
          click_button "Sign up"
        end

        describe 'swfs list' do
          before(:each) do
            FactoryGirl.create(:valid_video, :title => 'UniqueTitleOne')
            FactoryGirl.create(:valid_video, :title => 'UniqueTitleTwo')
          end

          it "shows two items" do
            visit refinery.swfs_admin_swfs_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create", :js => true do
          before(:each) do
            visit refinery.swfs_admin_swfs_path
            click_link "Add New Swf"
          end

          context "valid data for embed swf" do
            it "should succeed" do
              click_link "Use embedded swf"
              fill_in "swf_title", :with => "Swf Video"
              fill_in "swf_embed_tag", :with => '<iframe src="http://player.vimeo.com/video/39432556" width="500" height="281" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'
              click_button "Save"

              page.should have_content("'Test Swf' was successfully added.")
              Refinery::Swfs::Swf.count.should == 1
            end
          end

          context "valid data for file with url" do
            it "should succeed" do
              fill_in "swf_title", :with => "Test Swf"
              choose 'Use external source'
              fill_in 'swf_swf_files_attributes_0_external_url', :with => 'url'
              click_button "Save"
              page.should have_content("'Test Swf' was successfully added.")
              Refinery::Swfs::Swf.count.should == 1
            end
          end

          context "valid data for file with file" do
            it "should succeed" do
              fill_in "swf_title", :with => "Test Swf"
              file = File.join(Rails.root, 'spec/support/fixtures/video.flv')
              attach_file('swf_swf_files_attributes_0_file', file)
              click_button "Save"
              page.should have_content("'Test Swf' was successfully added.")
              Refinery::Swfs::Swf.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:valid_swf, :title => "Test Swf") }

          it "should succeed" do
            visit refinery.swfs_admin_swfs_path
            within ".actions" do
              click_link "Edit this swf"
            end
            fill_in "swf_title", :with => "A different file_name"
            click_button "Save"
            page.should have_content("'A different file_name' was successfully updated.")
            page.should have_no_content("Test Swf")
            page.should have_content("A different file_name")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:valid_swf, :title => "UniqueTitleOne") }
          it "should succeed" do
            visit refinery.swfs_admin_swfs_path
            click_link "Remove this swf forever"
            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Swfs::Swf.count.should == 0
          end
        end

        describe "insert swf" do
          before(:each) do
            FactoryGirl.create(:valid_swf, :title => "Test Swf1", :embed_tag => 'external_swf1')
            FactoryGirl.create(:valid_swf, :title => "Test Swf2", :embed_tag => 'external_vswf2')
          end
          it "should show list of available swf" do
            visit refinery.insert_swfs_admin_swfs_path
            page.should have_content("Test Swf1")
            page.should have_content("Test Swf2")
          end

        end

      end
    end
  end
end
