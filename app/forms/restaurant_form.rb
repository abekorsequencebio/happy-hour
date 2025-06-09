class RestaurantForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :restaurant
  attribute :restaurant
  attribute :name, :string
  attribute :address, :string
  attribute :phone, :string
  attribute :website, :string

  validates :name, presence: true

  def save
    return false unless valid?

    persist
  end

  private

  def persist
    ActiveRecord::Base.transaction do
      @restaurant ||= restaurant ? restaurant : Restaurant.new
      restaurant.update!(name: name, address: address, phone: phone, website: website)
    end
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "Whoops, an unexpected error prevented the samples from being added to a manifest: #{e.message}")
    false
  end
end
