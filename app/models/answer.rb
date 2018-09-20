class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  has_one :answer_rating

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
