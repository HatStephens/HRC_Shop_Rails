class ContactController < ApplicationController

  def show
    @item = Item.find(params[:id])
    @owner = User.find(@item.user_id)
  end

end
