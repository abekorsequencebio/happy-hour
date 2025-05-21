# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #

r1 = Restaurant.create!(
  name: "The Local Pub",
  address: "123 Main St",
  phone: "555-1234",
  website: "https://localpub.com"
)

r1.deals.create!(
  day: "Monday",
  start_time: "17:00",
  end_time: "20:00",
  description: "Two-for-one beers"
)

r1.deals.create!(
  day: "Wednesday",
  start_time: "16:00",
  end_time: "19:00",
  description: "Half-price appetizers"
)