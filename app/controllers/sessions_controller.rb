class SessionsController < ApplicationController
  def new; end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user.present?
      log_in(user)
      redirect_to root_path, notice: "#{user.name}, вы успешно залогинились!"
    else
      flash.now.alert = 'Неправильный мэйл или пароль'
      render :new # render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: 'Вы разлогинились! Приходите ещё!'
  end
end
