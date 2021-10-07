class SampleMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.send_when_update.subject
  #

  # def send_when_update(user)
  #   @user = user
  #   mail to: user.email,
  #         subject: '会員情報が更新されました。'
  # end

  def alert_when_posted(user, post)
    @user = user
    @post = post
    mail to: user.email,
          subject: "#{User.find(@post.user_id).name}さんが質問をしました"
  end

  def alert_when_commented(user, post, comment)
    @user = user
    @post = post
    @comment = comment
    mail to: user.email,
          subject: "#{User.find(@comment.user_id).name}さんが回答しました"
  end

end
