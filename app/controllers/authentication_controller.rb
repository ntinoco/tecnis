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

  def account_settings
     @user = current_user
  end

  def set_account_info
    old_user = current_user
    
    # Does it match with current password?
    @user = User.authenticate_by_username(old_user.username, params[:user][:password])

    # verify
    if @user.nil?
      @user = current_user
      @user.errors[:password] = "Contraseña errónea"
    else
      # If there is a new_password value, then we need to update the password.
      if !params[:user][:new_password].nil? && !params[:user][:new_password].empty?
        #raise @user.email
        @user.password = params[:user][:new_password]
        @user.save!
        #raise @user.id
        flash[:notice] = 'Se modificó la contraseña'
        render :action => 'sign_in'
      else
        @user.errors[:new_password] = 'Debe indicar algo como contraseña'
        render :action => "account_settings"
      end

    end
  end

end
