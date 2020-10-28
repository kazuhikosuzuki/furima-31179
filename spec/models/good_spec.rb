require 'rails_helper'

RSpec.describe 'Good', type: :model do
  before do
    @good = FactoryBot.build(:good)
  end
  context 'エラーメッセージの確認' do
    it '商品画像を1枚つけていないと登録できない' do
      @good.image = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Image can't be blank")
    end
    it '商品名がないと登録できない' do
      @good.shop_name = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Shop name can't be blank")
    end
    it '商品の説明がなければ登録できない' do
      @good.description = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Description can't be blank")
    end
    it 'カテゴリーの情報がなければ登録できない' do
      @good.category_id = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Category can't be blank")
    end
    it '商品の状態についての情報がなければ登録できない' do
      @good.condition_id = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Condition can't be blank")
    end
    it '配送料の負担についての情報がなければ登録できない' do
      @good.scheduled_delivery_id = nil
      @good.valid?
      expect(@good.errors.full_messages).to include('Shipping expense must be other than 1')
    end
    it '発送元の地域についての情報がなければ登録できない' do
      @good.prefecture_id = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Prefecture can't be blank")
    end
    it '発送までの日数についての情報がなければ登録できない' do
      @good.scheduled_delivery_id = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Scheduled delivery can't be blank")
    end
    it '価格についての情報がなければ登録できない' do
      @good.price = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Price can't be blank")
    end
    it '価格の範囲が、¥300~¥9,999,999の間でなければ登録できない' do
      @good.price = '299'
      @good.valid?
      expect(@good.errors.full_messages).to include('Price must be greater than 299')
      @good.price = '10000000'
      @good.valid?
      expect(@good.errors.full_messages).to include('Price must be less than 9999999')
    end
    it '販売価格は半角数字のみでなければ登録できない' do
      @good.price = '１２３４'
      @good.valid?
      expect(@good.errors.full_messages).to include('Price is not a number')
    end
  end
end
