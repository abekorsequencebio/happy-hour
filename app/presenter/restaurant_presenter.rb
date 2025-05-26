class RestaurantPresenter < ApplicationPresenter
	presents :restaurant

	def timestamp
		"#{deal.start_time.strftime("%l:%M %p")} – #{deal.end_time.strftime("%l:%M %p")}"
	end
end