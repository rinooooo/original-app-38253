require 'rails_helper'

RSpec.describe RestaurantForm, type: :model do
  describe '店の新規登録' do
    before do
      user = FactoryBot.create(:user)
      @restaurant_form = FactoryBot.build(:restaurant_form, user_id: user.id)
    end

    context '登録できる場合' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@restaurant_form).to be_valid
      end
      it 'addressが空でも登録できる' do
        @restaurant_form.address = ''
        expect(@restaurant_form).to be_valid
      end
      it 'phone_numberが空でも登録できる' do
        @restaurant_form.phone_number = ''
        expect(@restaurant_form).to be_valid
      end
      it 'urlが空でも登録できる' do
        @restaurant_form.url = ''
        expect(@restaurant_form).to be_valid
      end
      it 'imageが空でも登録できる' do
        @restaurant_form.image = nil
        expect(@restaurant_form).to be_valid
      end
    end

    context '登録できない場合' do
      it 'tag_nameが空だと登録できない' do
        @restaurant_form.tag_name = ''
        @restaurant_form.valid?
        expect(@restaurant_form.errors.full_messages).to include("Tag name can't be blank")
      end
      it 'shop_nameが空だと登録できない' do
        @restaurant_form.shop_name = ''
        @restaurant_form.valid?
        expect(@restaurant_form.errors.full_messages).to include("Shop name can't be blank")
      end
      it 'category_idが空だと登録できない' do
        @restaurant_form.category_id = ''
        @restaurant_form.valid?
        expect(@restaurant_form.errors.full_messages).to include("Category can't be blank")
      end
      it 'userが紐付いていないと登録できない' do
        @restaurant_form.user_id = nil
        @restaurant_form.valid?
        expect(@restaurant_form.errors.full_messages).to include("User can't be blank")
      end
      it 'category_idが1だと登録できない' do
        @restaurant_form.category_id = 1
        @restaurant_form.valid?
        expect(@restaurant_form.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end
