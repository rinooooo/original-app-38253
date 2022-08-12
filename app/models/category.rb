class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '和食' },
    { id: 3, name: 'イタリアン' },
    { id: 4, name: 'フレンチ' },
    { id: 5, name: '中華' },
    { id: 6, name: 'エスニック' },
    { id: 7, name: '多国籍' },
    { id: 8, name: '焼肉' },
    { id: 9, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :restaurants
end
