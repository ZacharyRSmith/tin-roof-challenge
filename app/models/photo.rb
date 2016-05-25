class Photo < ActiveRecord::Base
  belongs_to :album

  before_save :normalize_attrs

  validates :title,  presence: true, length: { maximum: 140 }

  private

    def normalize_attrs
      self.title = title.downcase
      if url
        self.url = url.downcase
      end
      if thumbnailUrl
        self.thumbnailUrl = thumbnailUrl.downcase
      end
    end
end
