# encoding: UTF-8

class AuthenticationController < ApplicationController

  def sign_in
    @user = User.new
  end

  def login
    username_or_email = params[:user][:username]
    password = params[:user][:password]

    if username_or_email.rindex('@')
      email=username_or_email
      user = User.authenticate_by_email(email, password)
    else
      username=username_or_email
      user = User.authenticate_by_username(username, password)
    end

    if user
      session[:user_id] = user.id
      flash[:notice] = 'Bienvenido.'
      redirect_to :products
      #redirect_to :root
    else
      flash.now[:error] = 'Usuario desconocido. Verifica nombre de usuarios y contraseña.'
      render :action => "sign_in"
    end

  end

  def signed_out
    session[:user_id] = nil
    #flash[:notice] = "You have been signed out."
    flash[:notice] = "Se cerró la sesión."
    redirect_to :root
  end
  
  def new_user
     @user = User.new
  end
 
  def register
    @user = User.new(params[:user])
  
    if @user.valid?
      @user.save
      UserMailer.welcome_email(@user).deliver
      session[:user_id] = @user.id
      flash[:notice] = 'Bienvenido.'
      redirect_to :root
    else
      render :action => "new_user"
    end
  end

end
