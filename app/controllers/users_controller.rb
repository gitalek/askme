# Users controller
class UsersController < ApplicationController
  before_action :load_user, except: %i[index create new]
  before_action :authorize_user, except: %i[index new create show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
    # render 'new'
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      notice = "#{@user.username}, вы зарегистрированы!"
      redirect_to root_url, notice: notice
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      notice = 'Данные обновлены'
      redirect_to user_path(@user), notice: notice
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Аккаунт был удалён :('
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end

  def load_user
    @user ||= User.find params[:id]
  end
end