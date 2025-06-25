class Discipline < ApplicationRecord
  belongs_to :professor
  has_and_belongs_to_many :users
  
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true
end
