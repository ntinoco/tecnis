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

  # get
  def forgot_password
    @user = User.new
  end

  # put
  def send_password_reset_instructions
    username_or_email = params[:user][:username]

    if username_or_email.rindex('@')
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end

    if user
      user.password_reset_token = SecureRandom.urlsafe_base64
      user.password_expires_after = 10.hours.from_now
      user.save
      UserMailer.reset_password_email(user).deliver
      flash[:notice] = 'Se han enviado por email las instrucciones para recuperar la contraseña.'
      redirect_to :sign_in
    else
      @user = User.new
      # put the previous value back.
      @user.username = params[:user][:username]
      @user.errors[:username] = 'no es un usuario registrado.'
      render :action => "forgot_password"
    end
  end

  # HTTP get
  def password_reset
    token = params.first[0]
    @user = User.find_by_password_reset_token(token)

    if @user.nil?
      flash[:error] = 'No ha sido solicitado el cambio de contraseña de este usuario.'
      redirect_to :root
      return
    end

    if @user.password_expires_after < DateTime.now
      clear_password_reset(@user)
      @user.save
      flash[:error] = 'La solicitud de camnio de contraseña ha caducado. Por favor, solicítalo de nuevo.'
      redirect_to :forgot_password
    end
  end

  # HTTP put
  def new_password
    username = params[:user][:username]
    @user = User.find_by_username(username)

    if verify_new_password(params[:user])
      @user.update_attributes(params[:user])
      @user.password = @user.new_password

      if @user.valid?
        clear_password_reset(@user)
        @user.save
        flash[:notice] = 'Se ha modificado la contraseña. Acceda con la nueva contraseña.'
        redirect_to :sign_in
      else
        render :action => "password_reset"
      end
    else
      @user.errors[:new_password] = 'La contraseña no puede estar en blanco y debe coincidir en ambos campos.'
      render :action => "password_reset"
    end
  end

  private

   def clear_password_reset(user)
     user.password_expires_after = nil
     user.password_reset_token = nil
   end

   def verify_new_password(passwords)
     result = true

     if passwords[:new_password].blank? || (passwords[:new_password] != passwords[:new_password_confirmation])
       result = false
     end

     result
   end

end
