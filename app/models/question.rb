class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :attachments, as: :attachable
  has_many :comments, as: :commented

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :comments, allow_destroy: true

  after_create :update_reputation

  private

  def update_reputation
    CalculateReputationJob.perform_later(self)
  end
end
