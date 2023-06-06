class Page < ActiveRecord::Base
  # RELATIONS
  belongs_to :user

  # VALIDATIONS
  validates :user,    presence: true
  validates :title,   presence: true, uniqueness: true
  validates :content, presence: true

  scope :with_state, ->(states) { where state: Array.wrap(states) }
end
