class HomeController < ApplicationController
  def index
  end
  
  def submit_mail
  	UserMailer.request_info(params).deliver
    flash[:notice] = 'Solicitud enviada correctamente.'
    redirect_to :gracias
  end
end
