class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :disciplines
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  
  # Versão não-depreciada do enum (compatível com Rails 8.0+)
  enum :role, [:user, :admin]
end
