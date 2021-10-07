# これは何？
QuestionAppという質問回答アプリ

# クローンのやり方
```
$ git colone https://github.com/higakijin/question-app.git
$ cd question-app
$ bundle
$ rails db:migrate
```

# メール送信機能の実装
Gemfileと同じディレクトリに.envを作成
```
$ touch .env
```
.envの中を以下のように編集
```
USER_EMAIL= <ここにgmailアカウント>
USER_PASSWORD= <gmailの2段階パスワードをコピペ>
```
[2段階パスワードはこちらを参照](https://support.google.com/accounts/answer/185839?hl=ja&co=GENIE.Platform%3DDesktop)



config/environments/development.rbの63行目をtrueに変更
```ruby
# 開発上、一時的にfalseに設定してます。
config.action_mailer.raise_delivery_errors = true
```

# Adminユーザーの作成方法
コンソール上から作成
```ruby
$ rails c
[1] pry(main)> user = User.new(name: "aaa", email: "aaa@gmail.com", password: "aaaaaa", password_confirmation: "aaaaaa")
[2] pry(main)> user.admin = true
[3] pry(main)> user.save
```

# Adminページへの遷移
ルートパスからadminページに移動することはできません。  
'/admin/posts', '/admin/users', '/admin/comments' のどれかにアクセスしてください。