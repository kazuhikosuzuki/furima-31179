## user テーブル

| Column             | Type   | Options                      |
| ------------------ | ------ | ---------------------------- |
| nick_name          | string | null: false                  |
| email              | string | null: false,uniqueness: true |
| password           | string | null: false,uniqueness: true |
| encrypted_password | string | null: false,uniqueness: true |
| last_name          | string | null: false                  |
| first_name         | string | null: false                  |
| last_name_kana     | string | null: false                  |
| first_name_kana    | string | null: false                  |
| date_of_birth      | date   | null: false                  |
### Association

- has_many :goods
- has_many :purchases

## goods テーブル

| Column                | Type            | Options                        |
| --------------------- | --------------- | ------------------------------ |
| image                 | (ActiveStorage) |                                |
| user_id               | references      | null: false, foreign_key: true |
| shop_name             | string          | null: false                    |
| description           | text            | null: false                    |
| price                 | integer         | null: false                    |
| category_id           | integer         | null: false                    |
| condition_id          | integer         | null: false                    |
| shipping_expense_id   | integer         | null: false                    |
| prefecture_id         | integer         | null: false                    |
| scheduled_delivery_id | integer         | null: false                    |
### Association

- belongs_to :user
- belongs_to :purchases

## purchases テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user_id  | references | null: false, foreign_key: true |
| goods_id | references | null: false, foreign_key: true |
### Association

- has_one :goods
- has_one :purchases_info
- belongs_to :user

## purchases_info テーブル

| Column         | Type       | Options                        |
| -------------- | -----------| ------------------------------ |
| postal_code    | string     | null: false,                   |
| prefecture_id  | integer    | null: false, foreign_key: true |
| city           | string     | null: false                    |
| building_name  | string     | null: false                    |
| phone_number   | string     | null: false                    |
| purchases_id   | references | null: false                    |
### Association
- belongs_to :purchases
