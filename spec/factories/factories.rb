FactoryBot.define do
  factory :widget do
    sequence(:name) { |n| "#{ActiveSupport::Inflector.ordinalize n} widget" }
  end
end
