# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| group_name         | string | null: false               |
| encrypted_password | string | null: false               |

### Association

- has_many :restaurants
- has_many :comments

- has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
- has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
- has_many :followings, through: :relationships, source: :followed
- has_many :followers, through: :reverse_of_relationships, source: :follower



## restaurants テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| shop_name          | string     | null: false                    |
| address            | string     |                                |
| category_id        | integer    | null: false                    |
| phone_number       | integer    |                                |
| url                | string     | null: false, unique: true      |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :comments
- has_many   :restaurant_tags
- has_many   :tags, through restaurant_tags



## comments テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| comment            | string     | null: false                    |
| restaurant         | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :restaurant



## tags テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| tag_name           | string     | null: false                    |

### Association
- has_many   :restaurant_tags
- has_many   :restaurants, through restaurant_tags



## restaurant_tags テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| restaurant   | references | null: false, foreign_key: true |
| tag          | references | null: false, foreign_key: true |

### Association

- belongs_to :restaurant
- belongs_to :tag



## relationships テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| follower     | references | null: false, foreign_key: true |
| followed     | references | null: false, foreign_key: true |

### Association

- belongs_to :follower, class_name: "User"
- belongs_to :followed, class_name: "User"
 
