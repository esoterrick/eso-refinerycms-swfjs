
FactoryGirl.define do
  factory :swf_file, :class => Refinery::Swfs::SwfFile do
    sequence(:file_name) { |n| "refinery_#{n}.swf" }
    file_size 
    file_ext 
    file_uid 
    file_mime_type 
    external_url 
    use_external 
  end
end

