class CommonlyUsedDestination < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { maximum: 8 }
  validates :address, presence: true
  validates :phone, presence: true , length: { is: 11 }
end
