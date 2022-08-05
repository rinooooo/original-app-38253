FactoryBot.define do
  factory :restaurant_form do
    shop_name { 'restaurant' }
    address { 'japantokyo' }
    category_id { '4' }
    phone_number { '080-3592-3333' }
    url { 'abcdefghijklmn' }
    tag_name { 'test' }
    image { Rack::Test::UploadedFile.new('spec/fixtures/staff2.jpg', 'image/jpg') }
  end
end
