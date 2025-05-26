class RestaurantForm
  include ActiveModel::Model
  include Virtus.model

  attribute :name
  attribute :address
  attribute :phone
  attribute :website

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
