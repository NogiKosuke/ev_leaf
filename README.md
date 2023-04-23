# User テーブル

|  id  |  user_name  |  email  |  password_digest  |
| ---- | ---- | ---- | ---- |
|  integer  |  string  |  string  |  string  |


# Task テーブル

|  id  |  user_id(FK)  |  title  |  content  |
| ---- | ---- | ---- | ---- |
|  integer  |  integer  |  string  |  text  |


# Stick (中間)テーブル

|  id  |  task_id(FK)  |  label_id(FK)  |
| ---- | ---- | ---- |
|  integer  |  integer  |  integer  |


# Labelテーブル

|  id  |  lbl_name  |
| ---- | ---- |
|  integer  |  string  |

#Herokuへのデプロイ手順

1.$ heroku create

2.gem 'net-smtp'
  gem 'net-imap'
  gem 'net-pop' をインストール

3.$ bundle install

4.$ heroku buildpacks:set heroku/ruby

5.$ hheroku buildpacks:add --index 1 heroku/nodejs

6.$ bundle lock --add-platform x86_64-linux

7.$ heroku stack:set heroku-20

8.package.jsonに下記を追加
  "engines": {
    "node": "16.x"
  },

9. yarn install

10.$ git push heroku master