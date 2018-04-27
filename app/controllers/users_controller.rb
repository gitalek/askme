class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'instarello',
        avatar_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUz0lGPYv9BTmms-UuRmAKyxRb5w25z62kbpIfr4ZeHh7ptY_7'
      ),
      User.new(
        id: 2,
        name: 'Misha',
        username: 'aristofun',
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    # @user = User.new(
    #   name: 'Vadim',
    #   username: 'instarello'
    # )
    @user = User.new(
      name: 'Vadim',
      username: 'instarello',
      avatar_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUz0lGPYv9BTmms-UuRmAKyxRb5w25z62kbpIfr4ZeHh7ptY_7'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'В чём смысл жизни?',
                   created_at: Date.parse('28.03.2016'))
    ]

    @new_question = Question.new
  end
end
