class User < ActiveRecord::Base
  has_many :addresses, dependent: :destroy

  before_save :normalize_attrs

  validates :username,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  private

    def normalize_attrs
      self.email = email.downcase
      if website
        self.website = website.downcase
      end
    end
end
