require 'rails_helper'

RSpec.describe PurchaseAdress, type: :model do
  before do
    @purchase_adress = FactoryBot.build(:purchase_adress)
  end

  it 'すべての値が正しく入力されていれば保存できること' do
    expect(@purchase_adress).to be_valid
  end

  it 'cityが空だと保存できないこと' do
    @purchase_adress.city = nil
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("City can't be blank")
  end

  it 'postal_codeが空だと保存できないこと' do
    @purchase_adress.postal_code = nil
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Postal code can't be blank")
  end
  it 'postal_codeにハイフンがあると保存できないこと' do
    @purchase_adress.postal_code = 1234567
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
  end

  it 'house_numberが空だと保存できないこと' do
    @purchase_adress.house_number = nil
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("House number can't be blank")
  end

  it 'building_nameは空でも保存できること' do
    @purchase_adress.building_name = nil
    expect(@purchase_adress).to be_valid
  end

  it 'prefectureが1だと保存できないこと' do
    @purchase_adress.prefecture_id = '1'
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Prefecture must be other than 1")
  end

  it 'phone_numberが空だと保存できないこと' do
    @purchase_adress.phone_number = nil
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Phone number can't be blank")
  end

  it 'phone_numberが全角数字だと保存できないこと' do
    @purchase_adress.phone_number = '１２３４５６７８９０１'
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Phone number Enter only numbers from 0 to 9 just 11 characters")
  end

  it 'phone_numberが11文字を超えると保存できないこと' do
    @purchase_adress.phone_number = 123456789012
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Phone number Enter only numbers from 0 to 9 just 11 characters")
  end

  it 'phone_numberが11文字を下回ると保存できないこと' do
    @purchase_adress.phone_number = 1234567890
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Phone number Enter only numbers from 0 to 9 just 11 characters")
  end

  it 'phone_numberが空だと保存できないこと' do
    @purchase_adress.phone_number = nil
    @purchase_adress.valid?
    expect(@purchase_adress.errors.full_messages).to include("Phone number can't be blank")
  end

end
