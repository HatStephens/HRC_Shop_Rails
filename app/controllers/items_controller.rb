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

  def show
    @item = Item.find(params[:id])
    @owner = User.find(@item.user_id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to "/items/#{@item.id}"
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Your pin has been removed successfully"
    redirect_to '/'
  end

end

def item_params
  params.require(:item).permit(:name, :description, :location, :PCNumber, :PCValue, :year, :price, :photo)
end
