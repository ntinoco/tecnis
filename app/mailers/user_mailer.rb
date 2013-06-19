class UserMailer < ActionMailer::Base
  default from: "no-reply-admin@tecnisolar.es"

  def welcome_email(user)
    @user = user
    @url = "<a href='http://www.tecnisolar.es/sign_in'>http://www.tecnisolar.es/sign_in</a>"
    @site_name = "Tecnisolar"
    mail(:to => user.email, :subject => "Bienvenid@ a Tecnisolar")
  end
end
