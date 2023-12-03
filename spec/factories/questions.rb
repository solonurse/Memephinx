FactoryBot.define do
  factory :question do
    sequence(:content) { |n| "#{n}問目" }
    sequence(:example) { |n| "例#{n}" }
    sequence(:answer) { |n| "答え#{n}" }
  end
end
