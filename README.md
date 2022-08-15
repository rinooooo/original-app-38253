# アプリケーション名
Share Restaurant

# アプリケーション概要
行きたいレストランを管理し、友人と共有することができる。
駅ごとにレストランを表示することができるため、店選びの時間を短縮することができる。
また、友人の登録したレストランも見ることができるため、店の候補の幅が広がる。

# URL
https://share-restaurant-38253.herokuapp.com/

# テスト用アカウント
| user     | email    | password     |
| -------- | -------- | ------------ |
| user1    | 1@test   | test1111     |
| user2    | 2@test   | test2222     |
| user3    | 3@test   | test3333     |

# 利用方法
## マイページ
店の登録と、店の管理ができる
- emailとパスワードを入力してログインする
- サイドバー登録する＋ボタンから店を登録する
- マイページの一覧から確認する
- 一覧表示の店名をクリックし、詳細ページで登録情報を確認する

## シェアページ
フォローしたユーザーが登録している店を見ることができる
- マイページサイドバーのシェアページをクリックする
- ログインユーザーとフォローしたユーザーが登録した店一覧が表示される

## 共通機能
店探し
- サイドバーの駅名から、駅店で店を探す
- サイドバーの検索フォームから、店名で店を探す
- カテゴリーを選択して店を絞る

友達追加
- サイドバー友達リスト＋ボタンからユーザーをフォローする
- フォローしたユーザーの登録した店はシェアページで見ることができる


# アプリケーションを作成した背景
普段から友人と食事に出かけるのが好きで、店選びの際グルメサイトをよく利用していましたが、何百件もの店から良さそうな店をピックアップしてlineで送り合うのが手間で、毎回時間がかかっていました。
また、店選びに役立てばと自分が行きたい店をiphoneのメモアプリに記入していましたが、メモアプリの中から探すのが面倒でなかなか活用できていませんでした。
そこで、自分が行きたい店を管理・共有できるアプリで、複数人の友人が登録した店をまとめて表示しその中から選ぶことができれば、店選びの度にグルメサイトを検索する必要がなくなり、店選びの時間短縮になると考えました。
周りの友人にも聞いてみると、同じ課題を抱えている人がいて、他にも同じ課題を抱えている人がいると推測し開発することにしました。

# 工夫した点
- 店登録の簡易化
- フォロー機能で友人とレストランを共有できる
- line共有機能
- 頻繁に使うタグ切り替えや店登録の非同期化 

# 要件定義
https://docs.google.com/spreadsheets/d/1eEnprWBhlHt8YYFLLLEyMcp6rCqfiZ44ccCDMCSD0kU/edit#gid=982722306

# 実施した機能についての画像やGIFおよびその説明

# 実施予定の機能
- フォローユーザーの中から特定のユーザー(複数)に絞って店を表示することができる機能

# データベース設計
![](img/original-app.svg)

## users テーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| group_name         | string | null: false               |
| email              | string | null: false               |
| encrypted_password | string | null: false               |

### Association
- has_many :restaurants
- has_many :comments
- has_many :gos
- has_many :wents
- has_many :relationships
- has_many :reverse_of_relationships
- has_many :followings, through: :relationships, class_name: 'Relationship', source: :followed
- has_many :followers, through: :reverse_of_relationships, class_name: 'Relationship', source: :follower


## restaurants テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| shop_name          | string     | null: false                    |
| address            | string     | null: false                    |
| phone_number       | integer    |                                |
| url                | string     |                                |
| category_id        | references | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many   :comments
- belongs_to :category
- has_one    :performance
- has_many   :restaurant_tags
- has_many   :tags, through restaurant_tags
- has_many   :gos
- has_many   :wents


## categories テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| category_name      | string     | null: false                    |

### Association
- has_many :restaurants


## performances テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| latitude           | float      | null: false                    |
| longitude          | float      | null: false                    |
| restaurant         | references | null: false, foreign_key: true |

### Association
- belongs_to :restaurant


## comments テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
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


## gos テーブル
| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| restaurant   | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association
- belongs_to :restaurant
- belongs_to :user


## wents テーブル
| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| restaurant   | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association
- belongs_to :restaurant
- belongs_to :user

 
# 画面遷移図
![](img/original-app-2.svg)

# 開発環境
- フロントエンド

&emsp; HTML, CSS, JavaScript, jQuery
- バックエンド

&emsp; Ruby on Rails(Ruby)
- インフラ

&emsp; Heroku(S3)
- OS

&emsp; Mac/Linux
- データベース

&emsp; MySQL/MariaDB
- タスク管理

&emsp; Github
