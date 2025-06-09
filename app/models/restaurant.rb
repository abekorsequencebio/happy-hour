class Restaurant < ApplicationRecord
	has_many :deals, dependent: :destroy
end
