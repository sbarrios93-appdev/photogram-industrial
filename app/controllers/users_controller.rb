class UsersController < ApplicationController
  before_action :get_user

  def get_user
    @user = User.find_by!(username: params.fetch(:username))
  end

  def show
  end

  def liked
  end

  def feed
  end

  def followers
  end

  def leaders
  end
end
