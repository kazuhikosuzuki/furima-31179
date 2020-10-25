require 'rails_helper'

RSpec.describe User, type: :model do
  describe ' ユーザー新規登録' do
    before do
      # 明示的にallow_forgery_protectionを有効にする
      ActionController::Base.allow_forgery_protection = true
    end

    after do
      # 他のテストケースに影響を与えないために無効にしておく
      ActionController::Base.allow_forgery_protection = false
    end

    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録/ユーザー情報' do
      it 'nick_nameが空では登録できないこと' do
        @user.nick_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nick name can't be blank")
      end

      it 'emailが空では登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性でなければ登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに＠がなければ登録できないこと' do
        @user.email = 'kazugmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが6文字以上であれば登録できること' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end

      it 'passwordが半角英数字混合での入力でなければ登録できないこと' do
        @user.password = '１２３４５qq'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is invalid')
      end

      it 'passwordはpassword_confirmationを含めどちらかがなければ登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが一致していなければ登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123457'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    context '新規登録/本人情報確認' do
      it 'ユーザー本名は、名字がなければ登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
      end

      it 'ユーザー本名は、名前がなければ登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'ユーザー本名(last_name)は、全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない' do
        @user.last_name = 'Suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'ユーザー本名(first_name)は、全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない' do
        @user.first_name = 'Suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'ユーザー本名のフリガナは、名字がなければ登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
      end

      it 'ユーザー本名のフリガナは、名前がなければ登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end

      it 'ユーザー本名のフリガナ(first_name_kana)は、全角（カタカナ）での入力がなければ登録できない' do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'ユーザー本名のフリガナは(last_name_kana)は、全角（カタカナ）での入力がなければ登録できない' do
        @user.last_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
    end

    it '生年月日の入力がなければ登録できない' do
      @user.birth_day = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログイン・ログアウトができる時' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # ヘッダーのログインボタンをクリックすることで、ログインページに遷移できることを確認
      expect(page).to have_content('ログイン')
      find('a.login').click
      # フォームに情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンをクリックする
      find('input[name="commit').click
      # ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されることを確認
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('taro')
      # ヘッダーのログアウトボタンをクリックすることで、ログアウトができることを確認
      find('a.logout').click
      # ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示されることを確認
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
  end
  context '会員登録ができる時' do
    it '保存されているユーザーの情報と合致すれば会員登録ができる' do
      # トップページに移動する
      visit root_path
      # トップページに会員録するボタンをクリックすることで、会員登録ページに遷移することを確認
      expect(page).to have_content('新規登録')
      find('a.sign-up').click
      expect(page).to have_content('会員情報入力')
    end
  end
end
