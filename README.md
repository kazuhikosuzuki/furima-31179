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
| birth_day          | date   | null: false                  |
### Association

- has_many :goods
- has_many :purchases

## goods テーブル

| Column                | Type            | Options                        |
| --------------------- | --------------- | ------------------------------ |
| user                  | references      | null: false, foreign_key: true |
| shop_name             | string          | null: false                    |
| description           | text            | null: false                    |
| price                 | integer         | null: false                    |
| category_id           | integer         | null: false                    |
| condition_id          | integer         | null: false                    |
| shipping_expense_id   | integer         | null: false                    |
| prefecture_id         | integer         | null: false                    |
| scheduled_delivery_id | integer         | null: false                    |
### Association
- has_one :purchase
- belongs_to :user

## purchases テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| good     | references | null: false, foreign_key: true |
### Association

- belongs_to :good
- has_one :purchases_info
- belongs_to :user

## purchases_info テーブル

| Column         | Type       | Options                        |
| -------------- | -----------| ------------------------------ |
| postal_code    | string     | null: false,                   |
| prefecture_id  | integer    | null: false,                   |
| city           | string     | null: false                    |
| building_name  | string     | 　　　　　　　                   |
| phone_number   | string     | null: false                    |
| purchases      | references | null: false, foreign_key: true |
### Association
- belongs_to :purchase
