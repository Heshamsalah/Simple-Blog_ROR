class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  acts_as_taggable #to make the post tagable
  mount_uploader :picture, PictureUploader #hook the uploader to the post
  belongs_to :user
  validate  :picture_size

  private
    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
