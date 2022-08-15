# アプリケーション名
Share Restaurant

# アプリケーション概要
行きたいレストランを管理し、友人と共有することができます。
友人が登録した店と、自分が登録した店をまとめて表示することができるため、店選びの時間を短縮することができます。

# URL
https://share-restaurant-38253.herokuapp.com/

# テスト用アカウント
| user     | email    | password     |
| -------- | -------- | ------------ |
| user1    | 1@test   | test1111     |
| user2    | 2@test   | test2222     |
| user3    | 3@test   | test3333     |

# 利用方法
自分が登録した店を管理するマイページと、友人と店を共有するシェアページを利用できます
## マイページ
- emailとパスワードを入力してログインする
- ログインユーザーが登録した店一覧が表示される

店の登録
- サイドバー登録する＋ボタンから店を登録する

友達追加
- サイドバー友達リスト＋ボタンからユーザーをフォローする
- フォローしたユーザーの登録した店はシェアページで見ることができる

## シェアページ
- マイページサイドバーのシェアページをクリックする
- ログインユーザーとフォローしたユーザーが登録した店一覧が表示される

## 共通機能
店探し
- サイドバーの駅名から、駅店で店を探す
- サイドバーの検索フォームから、店名で店を探す
- カテゴリーを選択して店を絞る
店詳細情報
- 一覧表示の店名をクリックし、詳細ページで登録情報を確認する


# アプリケーションを作成した背景
普段から友人と食事に出かけるのが好きで、店選びの際グルメサイトをよく利用していましたが、何百件もの店から良さそうな店をピックアップしてlineで送り合うのが手間で、毎回時間がかかっていました。
また、店選びに役立てばと自分が行きたい店をiphoneのメモアプリに記入していましたが、メモアプリの中から探すのが面倒でなかなか活用できていませんでした。
そこで、自分が行きたい店を管理・共有できるアプリで、複数人の友人が登録した店をまとめて表示しその中から選ぶことができれば、店選びの度にグルメサイトを検索する必要がなくなり、店選びの時間短縮になると考えました。
周りの友人にも聞いてみると、同じ課題を抱えている人がいて、他にも同じ課題を抱えている人がいると推測し開発することにしました。

# 工夫した点
- 店登録の簡易化

&emsp; 店を登録する際、入力に手間がかかると気軽に登録できないため、食べログサイトの「送る」に記載している内容をコピー&ペーストすれば、店名・住所・電話番号・食べログURLが自動で入力で切る機能を追加しました。
- 駅ごとに店を表示することができる

&emsp; 私自身、友人と店選びをする際、駅を決めてからレストランを探すことが多いため、駅ごとにレストランを表示できる機能を追加しました。
- line共有機能

&emsp; アプリを利用していない友人にも店情報を共有できるように、line共有機能を追加しました。
- Googleマップの表示

&emsp; 視覚的に登録されている店を確認できるように、Googleマップ表示機能を追加しました。
 
 

# 要件定義
https://docs.google.com/spreadsheets/d/1eEnprWBhlHt8YYFLLLEyMcp6rCqfiZ44ccCDMCSD0kU/edit#gid=982722306

# 実施した機能についての画像やGIFおよびその説明
## ログイン機能
GIF：ログインに成功し、マイページに遷移している様子

[![Image from Gyazo](https://i.gyazo.com/867dcb7aac090be69b2caaac7d3a15d7.gif)](https://gyazo.com/867dcb7aac090be69b2caaac7d3a15d7)

## 店登録機能
GIF：登録が成功し、登録した店が追加されている様子（非同期）

[![Image from Gyazo](https://i.gyazo.com/ad8da14d1b4d35f0388371d0d6e5e769.gif)](https://gyazo.com/ad8da14d1b4d35f0388371d0d6e5e769)

## 自動入力機能
GIF：店登録の際、食べログの情報を貼り付け、自動入力ボタンをクリックすると、店名・住所・電話番号・食べログURLのフォームに値が自動で入力されている様子（非同期）

[![Image from Gyazo](https://i.gyazo.com/bb160036cd96989d2a9bbb5e5e1e2e1b.gif)](https://gyazo.com/bb160036cd96989d2a9bbb5e5e1e2e1b)

## フォロー機能
GIF：友達リスト+をクリックするとユーザー一覧が表示され、フォローするボタンをクリックするとフォローリストにユーザーが追加されている様子

[![Image from Gyazo](https://i.gyazo.com/89261d03b625e279b05eb3bc0fd0b9c1.gif)](https://gyazo.com/89261d03b625e279b05eb3bc0fd0b9c1)

GIF：フォロー中のユーザーの横にはフォロー外すボタンが表示されており、クリックするとフォローリストからユーザーが削除されている様子

[![Image from Gyazo](https://i.gyazo.com/1da295f2d2ec9842444fbe77edf9993d.gif)](https://gyazo.com/1da295f2d2ec9842444fbe77edf9993d)

## 店名検索機能
GIF：「ビーフ」と検索し、「ビーフ」を含むレストランのみ表示させている様子（シェアページ）

[![Image from Gyazo](https://i.gyazo.com/876043a43d1e70ae4277a0d682c6dc82.gif)](https://gyazo.com/876043a43d1e70ae4277a0d682c6dc82)

## 駅名検索機能
GIF：横浜駅をクリックし、横浜駅で登録されたレストランを表示させている様子（シェアページ、非同期）

[![Image from Gyazo](https://i.gyazo.com/7517a250d533ed1df80595897898201e.gif)](https://gyazo.com/7517a250d533ed1df80595897898201e)

## カテゴリー検索機能
GIF：プルダウンでフレンチを選択し、カテゴリーがフレンチの店のみ表示させている様子（シェアページ、横浜駅クリック後）

[![Image from Gyazo](https://i.gyazo.com/a6c499bd8d6449c5b979818bdd75f5ad.gif)](https://gyazo.com/a6c499bd8d6449c5b979818bdd75f5ad)

## いいね機能
GIF：店のボックス内の行きたい・行ったボタンをクリックするとカウントが1増える様子（非同期）

[![Image from Gyazo](https://i.gyazo.com/43cc7a9f84fbf8515dab03bcfbe620ea.gif)](https://gyazo.com/43cc7a9f84fbf8515dab03bcfbe620ea)

### 詳細ページ
GIF：店名をクリックすると店詳細ページに遷移する様子

[![Image from Gyazo](https://i.gyazo.com/7c92abc005e35feb2482fff28cc1f16f.gif)](https://gyazo.com/7c92abc005e35feb2482fff28cc1f16f)

### Line共有機能
GIF：「Lineで送る」ボタンをクリックするとLineアプリが起動される様子

[![Image from Gyazo](https://i.gyazo.com/9a7bd7c14347ea951582e51e862eeac1.gif)](https://gyazo.com/9a7bd7c14347ea951582e51e862eeac1)

### 外部サイトへのアクセス
GIF：URLをクリックすると食べログサイトに遷移する様子

[![Image from Gyazo](https://i.gyazo.com/5d1b6d1cf0cea3ce65eac00c3ca3002f.gif)](https://gyazo.com/5d1b6d1cf0cea3ce65eac00c3ca3002f)

### 電話機能
GIF：電話番号をクリックすると電話アプリが起動する様子

[![Image from Gyazo](https://i.gyazo.com/92c5a9eb83c3034fd8ea757d1af5627f.gif)](https://gyazo.com/92c5a9eb83c3034fd8ea757d1af5627f)

### 店編集機能
GIF：ログインユーザーが登録した店の詳細ページには「店情報を編集」「店情報を削除」メモ一覧が追加されている。「店情報を編集」をクリックし、必要事項を入力して更新に成功すると、変更内容が反映されている様子（非同期）

[![Image from Gyazo](https://i.gyazo.com/0a762b0478f34d2755e9a259ae65b32e.gif)](https://gyazo.com/0a762b0478f34d2755e9a259ae65b32e)

### 店削除機能
GIF：「店情報を削除」をクリックすると、店が削除されマイページに遷移する様子。

[![Image from Gyazo](https://i.gyazo.com/0cd272e480e6192cf958d0ec0e19deb9.gif)](https://gyazo.com/0cd272e480e6192cf958d0ec0e19deb9)

### コメント機能
GIF：フォームに入力し、送信ボタンをクリックすると一覧表示欄に追加される。削除ボタンを押すと一覧表示欄より削除される（非同期）

[![Image from Gyazo](https://i.gyazo.com/d2e8c66c14e8562ee28bffd3877b203c.gif)](https://gyazo.com/d2e8c66c14e8562ee28bffd3877b203c)

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
