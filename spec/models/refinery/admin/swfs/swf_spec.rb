require 'spec_helper'

module Refinery
  module Swfs
    describe Swf do

      describe 'validate file presence' do
        subject { FactoryGirl.build(:swf) }
        before { subject.valid? }

        it { should be_invalid }
        its(:errors) { should include(:swf_files) }
      end

      describe 'validate embed_tag presence' do
        subject { FactoryGirl.build(:swf, :use_shared => true) }
        before { subject.valid? }

        it { should be_invalid }
        its(:errors) { should include(:embed_tag) }
      end

      describe 'should be valid' do
        subject { FactoryGirl.build(:valid_swf) }
        it { should be_valid }
      end

      describe 'should be valid again' do
        let(:swf_file) { FactoryGirl.build(:swf_file) }
        let(:swf) { FactoryGirl.build(:swf, :use_shared => false) }
        before {swf.swf_files << swf_file}
        it 'should be valid swf' do
          swf.should be_valid
        end
      end

      describe 'config' do
        let(:swf) { FactoryGirl.build(:valid_swf) }

        context 'get option' do
          before { swf.config = { :height => 100 } }
          it 'should return config option' do
            swf.height.should == swf.config[:height]
          end
        end

        context 'set option' do
          before { swf.config = { :height => 100 } }
          it 'should change config option' do
            expect { swf.height = 200 }.to change { swf.config[:height] }.from(100).to(200)
          end
        end

        context 'set default config when created' do
          let(:swf) { Swf.new }
          it 'should have config' do
            swf.config.class.should == Hash
            swf.config[:preload].should == 'true'
          end
        end

        context 'should save config' do
          let(:swf) { Swf.new(:use_shared => true, :embed_tag => 'swf', :title => 'swf') }
          it 'should save height' do
            swf.config[:height] = 100
            swf.save!
            swf.config[:height].should == 100
          end
        end

      end

      describe 'swf to_html method' do
        context 'with file' do
          let(:swf_file) { FactoryGirl.build(:swf_file) }
          let(:swf) { Swf.new(:use_shared => false) }
          before do
            swf_file.stub(:url).and_return('url_to_swf_file')
            swf.swf_files << swf_file
          end
          it 'should return swf tag with source' do
            swf.to_html.should match(/^<script.*<\/script>$/)
            swf.to_html.should match(/<source src=["']url_to_swf_file['"]/)
            swf.to_html.should match(/data-setup/)
          end
        end

        context 'with embedded video' do
          let(:video) do
            FactoryGirl.create(:valid_swf,
                               :embed_tag => "<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/L5J8cIQHlnY\" frameborder=\"0\" allowfullscreen></iframe>")
          end

          it 'should return swf tag with iframe' do
            swf.to_html.should match(/^<iframe.*<\/iframe>$/)
            swf.to_html.should match(/www\.youtube\.com/)
            swf.to_html.should match(/wmode=transparent/)
          end

          before do
            swf.config[:height] = 111
            swf.config[:width] = 222
          end

          it 'should set config from config before return tag' do
            swf.to_html.should match(/222.*111/)
          end
        end
      end

      describe 'short_info' do
        let(:swf) { FactoryGirl.build(:valid_swf) }
        let(:swf_file) { FactoryGirl.build(:swf_file, :use_external => false) }
        it 'should return short info' do
          swf.short_info.to_s.should match(/.shared_source/i)
          swf.use_shared = false
          swf.swf_files << swf_file
          swf.short_info.to_s.should match(/.file/i)
        end
      end

    end
  end
end
