class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to '/'
    else
      flash[:notice] = "Your pin has not been submitted."
      redirect_to '/'
    end
  end

end

def item_params
  params.require(:item).permit(:name, :description, :location, :PCNumber, :PCValue, :year, :price, :photo)
end
