class CommonlyUsedDestination < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { maximum: 8 }

  validates :address, presence: true

  VALID_PHONE_REGEX = /0[89]0\d{8}/
  validates :phone, presence: true , format: { with: VALID_PHONE_REGEX }
end
