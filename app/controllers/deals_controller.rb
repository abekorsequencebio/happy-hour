class DealsController < ApplicationController
  def index

  end

  def show
  end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      flash[:notice] = "Deal created successfully."
      redirect_to restaurants_path
    else
      flash.now[:alert] = "Error creating deal."
      render :new
    end
  end

  def edit
    @deal = Deal.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Deal not found."
    redirect_to restaurants_path
  end

  def update
    @deal = Deal.find(params[:id])
    if @deal.update(deal_params)
      flash[:notice] = "Deal updated successfully."
      redirect_to restaurants_path
    else
      flash.now[:alert] = "Error updating deal."
      render :edit
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Deal not found."
    redirect_to restaurants_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Error updating deal: #{e.message}"
    render :edit
  end

  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    flash[:notice] = "Deal deleted successfully."
    redirect_to restaurants_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Deal not found."
    redirect_to restaurants_path
  rescue ActiveRecord::DeleteRestrictionError
    flash[:alert] = "Cannot delete deal with associated records."
    redirect_to restaurants_path
  rescue StandardError => e
    flash[:alert] = "An error occurred while deleting the deal: #{e.message}"
    redirect_to restaurants_path
  end
  private
  def deal_params
    params.require(:deal).permit(:restaurant_id, :day, :start_time, :end_time, :description).to_h
  end
end
