class Professor < ApplicationRecord
  has_one :room, dependent: :nullify
  has_many :disciplines, dependent: :destroy
  
  validates :name, presence: true
  validates :specialization, presence: true
end
