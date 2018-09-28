class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :attachments, as: :attachable
  has_many :comments, as: :commented

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :comments, allow_destroy: true
end
