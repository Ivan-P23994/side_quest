class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture

  validates :username, presence: true
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true }
end
