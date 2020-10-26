class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :goods
         
  with_options presence: true do
    validates :email, uniqueness: true
    validates :nick_name
      zenkaku = /\A[ぁ-んァ-ン一-龥]+\z/
    validates :last_name, format: { with: zenkaku }
    validates :first_name, format: { with: zenkaku }
      kana = /\A[ァ-ン一]+\z/
    validates :last_name_kana, format: { with: kana }
    validates :first_name_kana, format: { with: kana }
    validates :birth_day
      PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates :password, format: { with: PASSWORD_REGEX }
  end
end
