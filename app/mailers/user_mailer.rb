# encoding: UTF-8

class UserMailer < ActionMailer::Base
  default from: "no-reply-admin@tecnisolar.es"

  def welcome_email(user)
    @user = user
    @url = "<a href='http://www.tecnisolar.es/sign_in'>http://www.tecnisolar.es/sign_in</a>"
    @site_name = "Tecnisolar"
    mail(:to => user.email, :subject => "Bienvenid@ a Tecnisolar")
  end

  def reset_password_email(user)
  	@user = user
    @password_reset_url = 'http://www.tecnisolar.es/password_reset?' + @user.password_reset_token
    mail(:to => user.email, :subject => "Tecnisolar: Regenerar contraseña")
  end
  
  def order_confirmation(cart, params)
    @cart   = cart
    @params = params
    mail(:to => "nacho.tinoco@gmail.com", :subject => "Tecnisolar: Nuevo Pedido")
  end
end
