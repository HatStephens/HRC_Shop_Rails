class UsersController < ApplicationController

  def mylisted
    @my_items = Item.where(:user_id => current_user.id)
  end

end
