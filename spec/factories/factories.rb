FactoryBot.define do
  factory :widget do
    sequence(:name) { |n| "#{ActiveSupport::Inflector.ordinalize n} widget" }
    sequence(:description) do |n|
      "Descriptioni for #{ActiveSupport::Inflector.ordinalize n} widget"
    end
  end
end
