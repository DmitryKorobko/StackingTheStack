class Comment < ApplicationRecord
  belongs_to :commented, polymorphic: true, touch: true

  validates :message, presence: true
end
