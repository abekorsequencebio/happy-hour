class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  def index
    @restaurants = Restaurant.order(created_at: :asc)
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
      redirect_to restaurants_path
    else
      flash.now[:alert] = "Error creating restaurant."
      render :new
    end
  end

  def edit
    @restaurant_form = RestaurantForm.new(restaurant: @restaurant, **@restaurant.slice(:name, :address, :phone, :website))
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Restaurant not found."
    redirect_to restaurants_path
  end

  def update
    @restaurant_form = RestaurantForm.new(restaurant_params.merge(restaurant: @restaurant))
    if @restaurant_form.save
      flash[:notice] = "Restaurant updated successfully."
      redirect_to restaurants_path
    else
      flash.now[:alert] = "Error updating restaurant."
      render :edit
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Restaurant not found."
    redirect_to restaurants_path
  end

  def destroy
    @restaurant.destroy
    flash[:notice] = "Restaurant deleted successfully."
    redirect_to restaurants_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Restaurant not found."
    redirect_to restaurants_path
  rescue ActiveRecord::DeleteRestrictionError
    flash[:alert] = "Cannot delete restaurant with associated deals."
    redirect_to restaurant_path(@restaurant)
  rescue StandardError => e
    flash[:alert] = "An error occurred while deleting the restaurant: #{e.message}"
    redirect_to restaurant_path(@restaurant)
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Restaurant not found."
    redirect_to restaurants_path
  end

  def restaurant_params
    params.require(:restaurant_form).permit(
      :name, :address, :phone, :website
    ).to_h
  end
end
