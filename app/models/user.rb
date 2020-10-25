class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :nick_name, presence: true
  zenkaku = /\A[ぁ-んァ-ン一-龥]+\z/
  validates :last_name, presence: true, format: { with: zenkaku }
  validates :first_name, presence: true, format: { with: zenkaku }
  kana = /\A[ァ-ン一]+\z/
  validates :last_name_kana, presence: true, format: { with: kana }
  validates :first_name_kana, presence: true, format: { with: kana }
  validates :birth_day, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX }
end
