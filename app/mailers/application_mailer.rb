class ApplicationMailer < ActionMailer::Base
  default  from:     "QuestionApp運営局 <#{ENV['USER_EMAIL']}>"
  layout 'mailer'
end
