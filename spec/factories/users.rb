FactoryBot.define do
  factory :user do
    group_name { 'test' }
    email                 { 'test@example' }
    password              { '000000' }
    password_confirmation { password }
  end
end
