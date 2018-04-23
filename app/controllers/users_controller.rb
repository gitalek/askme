class UsersController < ApplicationController
  def show
    @hello = 'Привет, Мишаня!'
  end

  def moo
    @hello = 'Привет, Мишаня!'
    @bye = 'Пока, Мишаня!'
  end
end
