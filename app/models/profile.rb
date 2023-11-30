class Profile < ApplicationRecord
  belongs_to :user
  has_many :tags_profiles
  has_many :tags, through: :tags_profiles
  validates :first_name, :last_name, :avatar
end
