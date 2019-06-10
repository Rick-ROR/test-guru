class UserBadgesController < ApplicationController
  def index
    @user_badges = UserBadge.all
  end
end
