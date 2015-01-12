class ItemsController < ApplicationController

  def index
    @items = Item.all

    if params[:search] && params[:keywordsearch]==""
      @filtered_items = []

      @items.each do |item|
        if (params[:search][:location] != 'n/a' && params[:search][:occasion] != 'n/a')
          @filtered_items << item if filter_both(item, params[:search])
        else
          @filtered_items << item if filter_location(item, params[:search])
          @filtered_items << item if filter_occasion(item, params[:search])
        end
      end

      if @filtered_items.empty?
        @items = []
        # flash[:notice] = "Sorry, no items match your Search criteria."
      else
        @items = @filtered_items.uniq
        flash[:notice] = ''
      end
    end

    if params[:keywordsearch]
      @filtered_items = []

      @items.each do |item|
        @filtered_items << item if item.name.downcase.include? "#{params[:keywordsearch].downcase}"
      end
      # @filtered_items = Item.where(:all, :conditions => ['name LIKE ?', "%#{params[:keywordsearch]}%"])

      if @filtered_items.empty?
        @items = []
        # flash[:notice] = "Sorry, no items match your Search criteria."
      else
        @items = @filtered_items.uniq
        flash[:notice] = ''
      end
    end

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
  params.require(:item).permit(:name, :description, :location, :PCNumber, :PCValue, :year, :price, :photo, :occasion)
end


def filter_both(item, params)
  location = params[:location]
  occasion = params[:occasion]
  check_both = true if (item.location == location && item.occasion == occasion)
end

def filter_location(item, params)
  location = params[:location]
  check_location = true if (item.location == location)
end

def filter_occasion(item, params)
  occasion = params[:occasion]
  check_occasion = true if (item.occasion == occasion)
end
