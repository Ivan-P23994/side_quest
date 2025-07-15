class User < ApplicationRecord
  USER_TYPES = %w[business volunteer organization].freeze

  scope :businesses, -> { where(user_type: 'business') }
  scope :volunteers, -> { where(user_type: 'volunteer') }
  scope :organizations, -> { where(user_type: 'organization') }

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :omni_auth_identities, dependent: :destroy

  validates :email_address, presence: true,
              format: { with: URI::MailTo::EMAIL_REGEXP },
              uniqueness: { case_sensitive: false }

  validates :password, on: [ :registration, :password_change ],
            presence: true,
            length: { minimum: 8, maximum: 72 }

  validates :user_type, presence: true, inclusion: { in: %w[business volunteer organization] }

  normalizes :email_address, with: ->(e) { e.strip.downcase }


  def self.create_from_oauth(auth)
    email = auth.info.email
    user = self.new email_address: email, password: SecureRandom.base64(64).truncate_bytes(64)
    # TODO: you could save additional information about the user from the OAuth sign in
    # assign_names_from_auth(auth, user)
    user.save
    user
  end

  def signed_in_with_oauth(auth)
    # TODO: same as above, you could save additional information about the user
    # User.assign_names_from_auth(auth, self):_
    # save if first_name_changed? || last_name_changed?
  end
end
