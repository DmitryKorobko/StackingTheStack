class Attachment < ApplicationRecord
  belongs_to :attachmentable, polymorphic: true

  validates :file, presence: true

  mount_uploader :file, FileUploader
end
