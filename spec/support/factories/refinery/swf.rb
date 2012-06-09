FactoryGirl.define do
  factory :swf, :class => Refinery::Swfs::Swf do
    sequence(:title) { |n| "swf_#{n}" }
    position nil
    config nil
    use_shared false
    embed_tag nil
  end
end


FactoryGirl.define do
  factory :valid_swf, :class => Refinery::Swfs::Swf do
    sequence(:title) { |n| "swf_#{n}" }
    position nil
    config nil
    use_shared true
    embed_tag '<iframe></iframe>'
  end
end

