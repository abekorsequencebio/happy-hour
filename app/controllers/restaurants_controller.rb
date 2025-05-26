class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @deals = @restaurant.deals
  end

  def new
    @restaurant_form = RestaurantForm.new
  end

  def create
    @restaurant_form = RestaurantForm.new(restaurant_params)
    if @restaurant_form.save
      flash[:notice] = "Restaurant created successfully."
      redirect_to restaurant_path(@restaurant)
    else
      flash.now[:alert] = "Error creating restaurant."
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Restaurant not found."
    redirect_to restaurant_index_path
  end

  def restaurant_params
    params.require(:restaurant).permit(
      :name, :address, :phone, :website
    ).to_h
  end
end
