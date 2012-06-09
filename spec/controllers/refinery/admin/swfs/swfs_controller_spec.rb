require 'spec_helper'

describe Refinery::Swfs::Admin::SwfsController do
  render_views

  before do
    @user = Refinery::User.create!(:username => 'admin@admin.com',
                                   :email => 'admin@admin.com',
                                   :password => 'admin@admin.com',
                                   :password_confirmation => 'admin@admin.com')
    @user.create_first
    sign_in @user
  end

  describe 'insert swf' do
    before do
      @swf = FactoryGirl.create(:valid_swf, :title => "TestSwf")
    end
    it 'should get swf html' do
      get :insert, :app_dialog => true, :dialog => true
      response.should be_success
      response.body.should match(/TestSwf/)
    end

    it 'should get preview' do
      get :dialog_preview, :id => "swf_#{@swf.id}", :format => :js
      response.should be_success
      response.body.should match(/iframe/)
    end

    it 'should get preview' do
      post :append_to_wym, :swf_id => @swf.id, 'swf' => {'height' => '100'}, :format => :js
      response.should be_success
      response.body.should match(/iframe/)
    end

  end

end
