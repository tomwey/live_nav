class MifiController < ApplicationController
  def login
    session[:imsi] = params[:imsi]
    session[:mid] = params[:mid]
  end

  def connect
    token = Digest::MD5.hexdigest("#{session[:imsi]}-#{session[:mid]}")
    # render text: Digest::MD5.hexdigest("#{session[:imsi]}-#{session[:mid]}")
    redirect_to('http://192.168.0.1/auth?token=' + token)
  end

  def auth
    token = params[:token]
    imsi  = params[:imsi]
    mid   = params[:mid]
    
    if Digest::MD5.hexdigest("#{imsi}-#{mid}") == token
      render text: true
    else
      render text: false
    end
  end
  
  def welcome
    
  end
end
