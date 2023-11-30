class Profile < ApplicationRecord
  belongs_to :user
  has_many :tags_profiles
  has_many :tags, through: :tags_profiles
  validates :first_name,      presence: true, if: :active_or_name?
  validates :last_name,     presence: true, if: :active_or_name?
  validates :avatar,  presence: true, if: :active_or_avatar?

  def active?
    status == 'active'
  end

  def active_or_name?
    status.include?('first_name') || status.include?('last_name') || active?
  end

  def active_or_avatar?
    status.include?('avatar') || active?
  end
end
