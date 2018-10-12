class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  has_one :answer_rating
  has_many :comments, as: :commented

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :comments, allow_destroy: true

  after_create :update_reputation

  private

  def update_reputation
    CalculateReputationJob.perform_later(self)
  end
end
