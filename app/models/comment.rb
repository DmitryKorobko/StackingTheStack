class Comment < ApplicationRecord
  belongs_to :commented, polymorphic: true

  validates :message, presence: true
end
