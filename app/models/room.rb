class Room < ApplicationRecord
  belongs_to :professor, optional: true
  
  validates :number, presence: true, uniqueness: true
end
